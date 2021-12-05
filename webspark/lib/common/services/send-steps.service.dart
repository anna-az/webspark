import 'package:dio/dio.dart';
import 'package:webspark/common/helpers/app-api.dart';
import 'package:webspark/store/models/task.model.dart';

Future<String> sendSteps(List<TaskModel> tasks, String path) async {
  final data = tasks.map((TaskModel task) => task.toJson(path)).toList();
  final Response<dynamic> res = await api.dio.post<dynamic>('api', data: data);
  final String message = res.data['message'] as String;

  return message;
}
