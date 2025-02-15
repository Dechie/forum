import 'package:forumapp/features/auth/datasource/auth_data_source.dart';
import 'package:forumapp/features/auth/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepository({required this.authDataSource});

  Future<User> login(String username, String password) async {
    final response = await authDataSource.login(username, password);

    // Extract token and user data
    final token = response['token'];
    final userData = response['user'];

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
    }

    return User.fromJson(userData);
  }

  Future<User> register(
      String name, String username, String email, String password) async {
    final response =
        await authDataSource.register(name, username, email, password);

    final token = response['token'];
    final userData = response['user'];

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
    }

    return User.fromJson(userData);
  }

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await authDataSource.getUser(token);
    return User.fromJson(response);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
