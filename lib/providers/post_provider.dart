import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants.dart';
import '../models/post.dart';
import '../models/user.dart';

class PostProvider extends ChangeNotifier {
  var usersBox = Hive.box('users');

  List<Post> _posts = [];
  List<Post> get posts => _posts;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  void setLoading(bool bool) {
    _isLoading = bool;
    notifyListeners();
  }

  Future createPost({
    required String content,
  }) async {
    var response;
    var dio = Dio();
    try {
      var data = {
        'content': content,
      };

      var token = usersBox.getAt(0)['token'];
      response = await dio.post(
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        '$url/feed/store',
        data: data,
      );
      if (response.statusCode == 201) {
        print(response.data['message']);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPosts() async {
    List<Post> posts = [];

    var dio = Dio();
    var response;

    var token = usersBox.getAt(0)['token'];

    try {
      response = await dio.get(
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        '$url/feeds',
      );

      if (response.statusCode == 200) {
        List<dynamic> datas = response.data;

        for (var data in datas) {
          print(data.toString());
          Map<String, dynamic> val = {};
          val['user'] = User.fromJson(data['user']);
          val['content'] = data['content'];
          posts.add(Post.fromJson(val));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    _posts = posts;
    notifyListeners();
  }
}
