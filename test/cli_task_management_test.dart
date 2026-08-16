import 'package:cli_task_management/exceptions/TaskExceptions.dart';
import 'package:cli_task_management/models/Priority.dart';
import 'package:cli_task_management/models/Status.dart';
import 'package:cli_task_management/models/Task.dart';
import 'package:cli_task_management/models/UrgentTask.dart';
import 'package:cli_task_management/repositories/Repository.dart';
import 'package:cli_task_management/repositories/TaskRepositoryJSON.dart';
import 'package:test/test.dart';

void main() {
     test('2.Récupération de toutes les tâches', () async {
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
        status: Status.PENDING,
      );

      await repository.addTask(task1);
      await repository.addTask(task2);
      final tasks = await repository.getAllTasks();

      expect(tasks.length, 2);
    });


test("5. Récupération des tâches par statut", () async {
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
   final pendingTasks = await repository.getTasksByStatus(Status.PENDING);
   final completedTasks = await repository.getTasksByStatus(Status.COMPLETED);

   expect(pendingTasks.length, 1);
   expect(completedTasks.length, 1);
  });

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

  test("7. test l'exception lors de la récupération d'une tâche inexistante", () async {
    final repository = TaskRepositoryJSON();
    expect(
      () async => await repository.getTaskById(999),
      throwsA(isA<TaskException>()),
    );
  });

  test('8. test l\'exception lors de la suppression d\'une tâche inexistante', () async {
    final repository = TaskRepositoryJSON();
    expect(
      () async => await repository.removeTask(999),
      throwsA(isA<TaskException>()),
    );
  });

  test('9. test l\'exception lors de la mise à jour d\'une tâche inexistante', () async {
    final repository = TaskRepositoryJSON();
    expect(
      () async => await repository.markTaskAsCompleted(999),
      throwsA(isA<TaskException>()),
    );
  });

  test('10. Récupération des tâches urgentes', () async {
    final repository = TaskRepositoryJSON();
    final task1 = UrgentTask(
      title: 'Urgent Task 1',
      description: 'First urgent task',
      dateLimit: DateTime.now(),
      priority: Priority.high,
      status: Status.PENDING,
      isUrgent: true, id: 1,
    );
    final task2 = Task(
      title: 'Urgent Task 2',
      description: 'Second urgent task',
      dateLimit: DateTime.now(),
      priority: Priority.medium,
      status: Status.PENDING
          );

    await repository.addTask(task1);
    await repository.addTask(task2);
    final urgentTasks = await repository.getUrgentTasks();
    print("TAILLE:"+urgentTasks.length.toString());
    expect(urgentTasks.length, 1);
    expect(urgentTasks.first.title, 'Urgent Task 1');
  });
}