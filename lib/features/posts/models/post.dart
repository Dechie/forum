import 'package:forumapp/features/auth/models/user.dart';

class Post {
  final int id;
  final User user;
  final String content;

  Post({required this.id, required this.user, required this.content});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      user: User.fromJson(json['user']),
      content: json['content'],
    );
  }
}
