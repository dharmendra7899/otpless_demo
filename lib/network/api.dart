import 'package:dio/dio.dart';

class Api {
  late Dio _dio;

  Api() {
    BaseOptions opts = BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    );

    _dio = Dio(opts);
  }

  Dio get sendRequest => _dio;
}
