import 'package:dio/dio.dart';

class AuthDataSource {
  final Dio dio;

  AuthDataSource({required this.dio});

  Future<Map<String, dynamic>> getUser(String token) async {
    try {
      final response = await dio.get('/user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch user data: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await dio.post('/login', data: {
        'username': username,
        'password': password,
      });

      return response.data; // Should contain user details & token
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> register(
      String name, String username, String email, String password) async {
    try {
      final response = await dio.post('/register', data: {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      });

      return response.data;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }
}
