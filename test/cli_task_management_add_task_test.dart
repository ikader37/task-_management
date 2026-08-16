import 'package:cli_task_management/exceptions/TaskExceptions.dart';
import 'package:cli_task_management/models/Priority.dart';
import 'package:cli_task_management/models/Status.dart';
import 'package:cli_task_management/models/Task.dart';
import 'package:cli_task_management/models/UrgentTask.dart';
import 'package:cli_task_management/repositories/Repository.dart';
import 'package:cli_task_management/repositories/TaskRepositoryJSON.dart';
import 'package:test/test.dart';
void main() {
  test('1. Ajout d\'une tâche', () async {
      final repository = TaskRepositoryJSON();
      final task = Task(
        title: 'Test Task',
        description: 'This is a test task',
        dateLimit: DateTime.now(),
        priority: Priority.medium,
        status: Status.PENDING,
      );

      await repository.addTask(task);
      final tasks = await repository.getAllTasks();

      expect(tasks.length, greaterThan(0));
    });
   
}