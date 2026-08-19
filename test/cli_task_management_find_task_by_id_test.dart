import 'package:cli_task_management/models/Priority.dart';
import 'package:cli_task_management/models/Status.dart';
import 'package:cli_task_management/models/Task.dart';
import 'package:cli_task_management/repositories/TaskRepositoryJSON.dart';
import 'package:test/test.dart';
void main() {
test("4. Récupération d'une tâche par ID", () async {
   final repository = TaskRepositoryJSON();
   final task = Task(
     title: 'Task to retrieve',
     description: 'This task will be retrieved by ID',
     dateLimit: DateTime.now(),
     priority: Priority.medium,
     status: Status.PENDING,
   );

   await repository.addTask(task);
   final retrievedTask = await repository.getTaskById(task.id);

   expect(retrievedTask?.title, 'Task to retrieve');
 });
 
}