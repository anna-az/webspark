import 'dart:io';
import 'package:dio/dio.dart';
import 'package:webspark/common/helpers/app-constants.dart';

AppApi api = AppApi();

class AppApi {
  AppApi() {
    dio.interceptors.addAll(<Interceptor>[
      InterceptorsWrapper(
          onRequest: (RequestOptions requestOptions,
              RequestInterceptorHandler handler) async {
            dio.interceptors.requestLock.lock();
            dio.interceptors.requestLock.unlock();
            return handler.next(requestOptions);
          },
          onError: (DioError e, ErrorInterceptorHandler handler) async {
            print('app-api dioerror: $e');
            return handler.next(e);
          },
          onResponse:
              (Response<dynamic> res, ResponseInterceptorHandler handler) =>
                  handler.next(res)),
    ]);
  }

  final Dio dio = Dio(BaseOptions(
    connectTimeout: 10000,
    baseUrl: AppConstants.baseUrl,
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ));

  final Dio dioNoBaseUrl = Dio(BaseOptions(
    connectTimeout: 10000,
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ));
}
