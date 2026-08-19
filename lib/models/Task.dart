import 'package:cli_task_management/models/Priority.dart';
import 'package:cli_task_management/models/Status.dart';

 class Task {
  int id;
  String title;
  String? description;
  DateTime dateLimit;
  Priority? priority;
  Status? status;

  Task({
    required this.title,
    this.description,
    required this.dateLimit,
    required this.priority,
    this.status,
    this.id = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateLimit': dateLimit.toUtc().toIso8601String(),
      'priority': priority?.name,
      'status': status?.name,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description']??'',
      dateLimit: DateTime.parse(json['dateLimit']),
      priority: json['priority'] != null ? Priority.values.byName(json['priority'] as String) : null,
      status: json['status'] != null ? Status.values.byName(json['status'] as String) : null,
    );
  }
}
