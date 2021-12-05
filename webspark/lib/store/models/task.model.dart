import 'package:webspark/store/models/cell.model.dart';
import 'package:webspark/store/models/coordinate.model.dart';

class TaskModel {
  TaskModel({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
    this.steps,
  });
  String id;
  List<String> field;
  CoordinateModel start;
  CoordinateModel end;
  List<CellModel>? steps;

  static TaskModel fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      field: List<String>.from(json['field']),
      start: CoordinateModel.fromJson(json['start'] as Map<String, dynamic>),
      end: CoordinateModel.fromJson(json['end'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson(String path) => <String, dynamic>{
        'id': id,
        'result': {
          'path': path,
          'steps': [...steps!.map((e) => e.toJson()).toList()]
        },
      };
}
