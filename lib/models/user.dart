class User {
  User({
    required this.name,
    required this.email,
    required this.username,
    this.password = '',
    this.key = 0,
    required this.token,
  });

  final String name, username, email, password, token;
  int key = 0;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      token: json['token'] ?? '',
    );
  }

  factory User.fromHive(Map<dynamic, dynamic> hive) {
    return User(
      name: hive['name'],
      username: hive['username'],
      email: hive['email'],
      token: hive['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'token': token,
    };
  }
}
