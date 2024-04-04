class User {
  String userId; //Token
  String avatar;
  String userName;
  List<Map<String, dynamic>> roles;

  User.empty()
      : userId = '',
        avatar = '',
        userName = '',
        roles = [];

  User(
      {required this.userId,
      required this.avatar,
      required this.userName,
      required this.roles});

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['token'] ?? '',
        avatar: json['avatar'] ?? '',
        userName: json['userName'] ?? '',
        roles: (json['roles'] as List<dynamic>? ?? [])
            .map((role) => role as Map<String, dynamic>)
            .toList(),
      );
}
