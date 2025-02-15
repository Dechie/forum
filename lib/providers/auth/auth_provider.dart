import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forumapp/core/constants.dart';
import 'package:hive/hive.dart';

import '../../features/auth/models/user.dart';

class AuthProvider extends ChangeNotifier {
  bool _isRegistered = false;
  bool _isLoading = false;

  final _usersBox = Hive.box('users');

  User? _user;

  bool get isLoading => _isLoading;
  bool get isRegistered => _isRegistered;

  User? get user => _user;
  Future<int> login({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    int stcode = 500;
    var data = {
      'username': username,
      'password': password,
    };

    Response response;
    try {
      var dio = Dio();
      response = await dio.post(
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
        '$url/login',
        data: data,
      );

      if (response.statusCode == 200) {
        stcode = 200;
        var userJson = response.data['user'];
        userJson['token'] = response.data['token'];
        _user = User.fromJson(userJson);

        //_addOrUpdate(_user);

        var keys = _usersBox.keys.toList();
        await _usersBox.deleteAll(keys);
        await _usersBox.add(_user!.toJson());

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Column(
                children: [
                  const Text('User data if response 200'),
                  //Text(e.toString()),
                  Text(response.data['message']),
                ],
              ),
            ),
          );
        }

        _isRegistered = true;
        notifyListeners();
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Column(
                children: [
                  //const Text('user data:'),
                  const Text('User data if response not 200'),
                  //Text(e.toString()),
                  Text(response.data['message']),
                ],
              ),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Column(
              children: [
                const Text('Error, Something went wrong'),
                Text(e.toString()),
              ],
            ),
          ),
        );
      }
      setLoading(false);
    }
    return stcode;
  }

  Future<int> register({
    required String name,
    required String username,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    int stcode = 500;
    var data = {
      'name': name,
      'username': username,
      'email': email,
      'password': password
    };

    Response response;
    try {
      var dio = Dio();
      response = await dio.post(
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
        '$url/register',
        data: data,
      );

      if (response.statusCode == 201) {
        stcode = 201;
        var userJson = response.data['user'];
        userJson['token'] = response.data['token'];
        _user = User.fromJson(userJson);

        var keys = _usersBox.keys.toList();
        await _usersBox.deleteAll(keys);
        await _usersBox.add(_user!.toJson());

        _isRegistered = true;
        notifyListeners();
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.red,
                content: Column(
                  children: [
                    const Text('Error, Something went wrong'),
                    //Text(e.toString()),
                    Text(response.data['message']),
                  ],
                )),
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Column(
                children: [
                  const Text('Error, Something went wrong'),
                  Text(e.toString()),
                ],
              )),
        );
      }
      setLoading(false);
    }
    return stcode;
  }

  void setLoading(bool bool) {
    _isLoading = bool;
    notifyListeners();
  }

  void _addOrUpdate(User? user) {
    final userkey = _usersBox.keys.firstOrNull((usr) =>
        usr['username'] == user!.username && usr['email'] == user.email);

    if (userkey != null) {
      _usersBox.put(userkey, user);
    } else {
      _usersBox.add(user);
    }
  }
}
