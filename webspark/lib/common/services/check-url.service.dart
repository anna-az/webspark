import 'package:dio/dio.dart';
import 'package:webspark/common/helpers/app-api.dart';

Future<String> checkUrl(String url) async {
  final Response<dynamic> res = await api.dioNoBaseUrl.post<dynamic>(url);
  final String message = res.data['message'] as String;
  return message;
}
