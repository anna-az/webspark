import 'package:dio/dio.dart';
import 'package:webspark/common/helpers/app-api.dart';
import 'package:webspark/store/models/task.model.dart';

Future<List<TaskModel>> getTasks() async {
  final Response<dynamic> res = await api.dio.get<dynamic>(
    'api',
  );

  final List<dynamic> cards = res.data['data'] as List<dynamic>;
  return cards
      .map<TaskModel>(
          (dynamic task) => TaskModel.fromJson(task as Map<String, dynamic>))
      .toList();
}
