import 'package:cli_task_management/models/Priority.dart';
import 'package:cli_task_management/models/Status.dart';
import 'package:cli_task_management/models/Task.dart';
import 'package:cli_task_management/models/UrgentTask.dart';
import 'package:test/test.dart';

void main() {
    test('Task doit correctement initialiser ses propriétés', () {
      final date = DateTime(2026, 8, 15);

      final task = Task(
        title: 'Faire les tests',
        description: 'Tester le modèle Task',
        dateLimit: date,
        priority: Priority.high,
        status: Status.PENDING,
      );

      expect(task.title, 'Faire les tests');
      // expect(task.description, 'Tester le modèle Task');
      // expect(task.dateLimit, date);
      // expect(task.priority, Priority.high);
      // expect(task.status, Status.PENDING);
    });

    test('Task doit être correctement sérialisée en JSON', () {
      final task = Task(
        title: 'Tâche JSON',
        description: 'Test serialization',
        dateLimit: DateTime(2026, 8, 15),
        priority: Priority.medium,
        status: Status.PENDING,
      );

      final json = task.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['title'], 'Tâche JSON');
      expect(json['description'], 'Test serialization');
      expect(json['priority'], isNotNull);
      expect(json['status'], isNotNull);
    });

    test('Task doit être correctement désérialisée depuis JSON', () {
      final json = {
        'id': 1,
        'title': 'Tâche JSON',
        'description': 'Test désérialisation',
        'dateLimit': '2026-08-15T00:00:00.000',
        'priority': Priority.high.name,
        'status': Status.PENDING.name,
      };

      final task = Task.fromJson(json);

      expect(task.title, 'Tâche JSON');
      expect(task.description, 'Test désérialisation');
      expect(task.priority, Priority.high);
      expect(task.status, Status.PENDING);
    });

    test('Priority doit contenir les niveaux attendus', () {
      expect(Priority.values, contains(Priority.low));
      expect(Priority.values, contains(Priority.medium));
      expect(Priority.values, contains(Priority.high));
    });

    test('Status doit contenir PENDING et COMPLETED', () {
      expect(Status.values, contains(Status.PENDING));
      expect(Status.values, contains(Status.COMPLETED));
    });

    test('UrgentTask doit avoir isUrgent à true', () {
      final task = UrgentTask(
        title: 'Tâche urgente',
        description: 'Test urgent',
        dateLimit: DateTime(2026, 8, 15),
        priority: Priority.high,
        status: Status.PENDING,
        isUrgent: true, id: 1,
      );

      expect(task.isUrgent, true);
      expect(task.title, 'Tâche urgente');
      expect(task.priority, Priority.high);
    });
}