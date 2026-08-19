import 'dart:async';
import 'dart:convert';

import 'package:cli_task_management/exceptions/TaskExceptions.dart';
import 'package:cli_task_management/models/Task.dart';
import 'package:cli_task_management/models/Status.dart';
import 'package:cli_task_management/models/Priority.dart';
import 'package:cli_task_management/models/UrgentTask.dart';
import 'package:cli_task_management/repositories/FileStorage.dart';
import 'package:cli_task_management/repositories/Repository.dart';
import 'package:collection/collection.dart';

class TaskRepositoryJSON implements Repository<Task> {
  FileStorage storage = new FileStorage(path: 'tasks.json');

  List<Task> _tasks = [];
  TaskRepositoryJSON();
  // Future<File> _getFile() async {
  //   return File('tasks.json');
  // }

@override
  Future<void> init() async {
    _tasks = [];
    try {
      final jsonString = await storage.read();

      if (jsonString.trim().isEmpty) {
        _tasks = [];
        return;
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);

      _tasks = jsonList
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();
    } on FormatException catch (e) {
      throw TaskFileReadException(
        'Le fichier tasks.json contient un JSON invalide : ${e.message}',
      );
    } on TaskException {
      rethrow;
    } catch (e) {
      throw TaskFileReadException('Erreur lors du chargement des tâches : $e');
    }
  }

  @override
  Future<void> addTask(Task task) async {
    final maxId = _tasks.isEmpty
        ? 0
        : _tasks.map((t) => t.id).reduce((a, b) => a > b ? a : b);
    task.id = maxId + 1; // Assign a unique ID based on the current maximum ID
    _tasks.add(task);
    await storage.write(
      jsonEncode(_tasks.map((task) => task.toJson()).toList()),
    );
  }

  @override
  Future<List<Task>> getAllTasks() async {
    // final jsonString = await storage.read();
    // final List<dynamic> jsonList = jsonDecode(jsonString);
    // // if (jsonList.isEmpty) {
    // //   throw TaskException('No tasks found in the JSON file.');
    // // }
    // _tasks = jsonList.map((json) => Task.fromJson(json)).toList();
    // return _tasks;
    return List.unmodifiable(_tasks);
  }

  @override
  Future<List<Task>> getTasksByPriority(Priority priority) async {
    // final allTasks = await getAllTasks();
    // return allTasks.where((task) => task.priority == priority).toList();
    return _tasks.where((task) => task.priority == priority).toList();
  }

  @override
  Future<List<Task>> getTasksByStatus(Status status) async {
    // final allTasks = await getAllTasks();
    // return allTasks.where((task) => task.status == status).toList();
    return _tasks.where((task) => task.status == status).toList();
  }

  @override
  Future<void> removeTask(int taskId) async {
    try {
      final task = _tasks.firstWhereOrNull((task) => task.id == taskId);
      if (task == null) {
        throw TaskNotFoundException(taskId.toString());
      }
      _tasks.removeWhere((task) => task.id == taskId);
    } on TaskException catch (e) {
      throw TaskFileReadException(
        'Erreur lors de la suppression de la tâche : ${e.message}',
      );
    }
    await storage.write(
      jsonEncode(_tasks.map((task) => task.toJson()).toList()),
    );
  }

  @override
  Future<Task> getTaskById(int taskId) async {
    final task = _tasks.firstWhereOrNull((task) => task.id == taskId);
    if (task != null) {
      return Future.value(task);
    } else {
      throw TaskNotFoundException(taskId.toString());
    }
  }

  @override
  Future<void> markTaskAsCompleted(int taskId) async {
    final task = _tasks.firstWhereOrNull((task) => task.id == taskId);
    if (task != null) {
      task.status = Status.COMPLETED;

      return storage.write(
        jsonEncode(_tasks.map((task) => task.toJson()).toList()),
      );
    } else {
      throw TaskNotFoundException(taskId.toString());
    }
  }

  @override
  Future<List<UrgentTask>> getUrgentTasks() async {
   final jsonString = await storage.read();
final List<dynamic> jsonList = jsonDecode(jsonString);

return jsonList
    .whereType<Map<String, dynamic>>()
    .where((json) => json['isUrgent'] == true)
    .map(UrgentTask.fromJson)
    .toList();
  }

  @override
  Future<List<Task>> listTasksByDate(String date) async {
    // final List<Task> tasksOnDate = _tasks.where((task) {
    //   final taskDate = task.dateLimit.toIso8601String().split('T')[0];
    //   return taskDate == date;
    // }).toList();
    // return tasksOnDate;
    return _tasks.where((task) {
      final taskDate = task.dateLimit.toIso8601String().split('T').first;

      return taskDate == date;
    }).toList();
  }
}
