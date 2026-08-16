import 'package:cli_task_management/exceptions/TaskExceptions.dart';
import 'package:cli_task_management/models/Priority.dart';
import 'package:cli_task_management/models/Status.dart';
import 'package:cli_task_management/models/Task.dart';
import 'package:cli_task_management/models/UrgentTask.dart';
import 'package:cli_task_management/repositories/Repository.dart';
import 'package:cli_task_management/repositories/TaskRepositoryJSON.dart';
import 'package:test/test.dart';
void main() {
  test("3. Marquer une tâche comme terminée", () async {
   final repository = TaskRepositoryJSON();
   final task = Task(
     title: 'Task to complete',
     description: 'This task will be marked as completed',
     dateLimit: DateTime.now(),
     priority: Priority.medium,
     status: Status.PENDING,
   );

   await repository.addTask(task);
   await repository.markTaskAsCompleted(task.id);
   final updatedTask = await repository.getTaskById(task.id);

   expect(updatedTask?.status, Status.COMPLETED);
 });
}
