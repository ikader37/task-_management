 abstract class TaskException implements Exception {
  final String message;
  TaskException(this.message);

}
/// Thrown when a task cannot be found by its ID
class TaskNotFoundException extends TaskException {
  final String taskId;

  TaskNotFoundException(this.taskId)
      : super('Task with ID "$taskId" was not found.');
}

/// Thrown when task input data fails validation
class InvalidTaskDataException extends TaskException {
  InvalidTaskDataException(String message)
      : super('INVALID_TASK_DATA');
}

 class TaskFileReadException extends TaskException {
  TaskFileReadException(String message)
      : super('TASK_FILE_READ_ERROR: $message');
}