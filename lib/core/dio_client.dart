import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:8001/api",
      connectTimeout: const Duration(seconds: 10), // 5 seconds
      receiveTimeout: const Duration(seconds: 10), // 3 seconds

      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static Dio get instance => _dio;

  static void setToken(String? token) {
    _dio.options.headers['Authorization'] =
        token != null ? 'Bearer $token' : null;
  }
}
