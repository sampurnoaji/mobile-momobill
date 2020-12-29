import 'package:dio/dio.dart';

import 'logging_interceptor.dart';

Dio getDio() {
  Dio dio = Dio();
  dio.options.baseUrl = 'https://unsplash.com';
  dio.options.connectTimeout = 5000; //5s
  dio.options.receiveTimeout = 3000;
  dio.interceptors.add(LoggingInterceptor());
  return dio;
}