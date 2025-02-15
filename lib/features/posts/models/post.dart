import '../../auth/models/user.dart';

class Post {
  Post({
    required this.content,
    required this.user,
  });

  final String content;
  final User user;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      content: json['content'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
    };
  }
}
