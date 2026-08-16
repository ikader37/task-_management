import 'package:cli_task_management/models/Task.dart';
import 'package:cli_task_management/models/Status.dart';
import 'package:cli_task_management/models/Priority.dart';
import 'package:cli_task_management/models/UrgentTask.dart';

abstract interface class Repository<T> {
  Future<void> addTask(Task task);
  Future<void> removeTask(int taskId);
  Future<T> getTaskById(int taskId);
  Future<void> markTaskAsCompleted(int taskId);
  Future<List<T?>> getAllTasks();
  Future<List<T?>> getTasksByStatus(Status status);
  Future<List<T?>> getTasksByPriority(Priority priority);
  Future<List<T?>> getUrgentTasks();
  Future<void> init();
  Future<List<T?>> listTasksByDate(String date);
}