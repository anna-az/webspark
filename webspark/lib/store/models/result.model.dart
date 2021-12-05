import 'package:webspark/store/models/coordinate.model.dart';
import 'package:webspark/store/models/task.model.dart';

class ResultModel {
  ResultModel({
    required this.task,
    this.steps,
  });
  TaskModel task;
  List<CoordinateModel>? steps;
}
