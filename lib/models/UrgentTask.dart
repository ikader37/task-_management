import 'package:cli_task_management/models/Priority.dart';
import 'package:cli_task_management/models/Status.dart';
import 'package:cli_task_management/models/Task.dart';
import 'package:cli_task_management/models/Urgent.dart';

class UrgentTask extends Task implements Urgent {
   @override
  final bool isUrgent;

    UrgentTask({
      required super.title,
      super.description,
      required super.dateLimit,
      required super.priority,
      this.isUrgent = false,
      super.status, 
      required super.id,
    });

    factory UrgentTask.fromJson(Map<String, dynamic> json) {
      return UrgentTask(
        title: json['title'],
        dateLimit: DateTime.parse(json['dateLimit']),
        priority: json['priority'] != null ? Priority.values.byName(json['priority'] as String) : null,
        isUrgent: json['isUrgent'] ?? false,
        status: json['status'] != null ? Status.values.byName(json['status'] as String) : null,
        id: json['id'] ,
      );
    }

    @override
    Map<String, dynamic> toJson() {
      final json = super.toJson();
      json['isUrgent'] = isUrgent;
      return json;
    }

    @override
    String getUrgencyMessage() {
      return isUrgent ? "Cette tâche est urgente!" : "Cette tâche n'est pas urgente.";
    }
}