import 'package:webspark/store/models/task.model.dart';

class GetTasksPending {}

class GetTasksSuccess {
  const GetTasksSuccess(this.tasks);
  final List<TaskModel> tasks;
}

class GetTasksError {}
