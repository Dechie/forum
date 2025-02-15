class Post {
  final int id;
  final int userId;
  final String content;
  final String userName;
  final String userEmail;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.userName,
    required this.userEmail,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      userName: json["user"]["name"],
      userEmail: json["user"]["email"],
      content: json['content'],
    );
  }
}
