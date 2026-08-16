
import 'package:cli_task_management/exceptions/TaskExceptions.dart';
import 'package:cli_task_management/models/Priority.dart';
import 'package:cli_task_management/models/Status.dart';
import 'package:cli_task_management/models/Task.dart';
import 'package:cli_task_management/models/UrgentTask.dart';
import 'package:cli_task_management/repositories/Repository.dart';
import 'package:cli_task_management/repositories/TaskRepositoryJSON.dart';
import 'package:test/test.dart';

void main() {

  test("6. Récupération des tâches par priorité", () async {
    final repository = TaskRepositoryJSON();
    final task1 = Task(
      title: 'Task 1',
      description: 'First task',
      dateLimit: DateTime.now(),
      priority: Priority.low,
      status: Status.PENDING,
    );
    final task2 = Task(
      title: 'Task 2',
      description: 'Second task',
      dateLimit: DateTime.now(),
      priority: Priority.high,
      status: Status.COMPLETED,
    );

    await repository.addTask(task1);
    await repository.addTask(task2);
    final lowPriorityTasks = await repository.getTasksByPriority(Priority.low);
    final highPriorityTasks = await repository.getTasksByPriority(Priority.high);

    expect(lowPriorityTasks.length, 1);
    expect(highPriorityTasks.length, 1);
  });

}