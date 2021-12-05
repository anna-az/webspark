import 'package:webspark/store/models/task.model.dart';

class SendStepsPending {
  const SendStepsPending(this.tasks, this.path);
  final List<TaskModel> tasks;
  final String path;
}

class SendStepsSuccess {}
