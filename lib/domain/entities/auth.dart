class Auth {
  final String username;

  Auth({
    required this.username,
  });

  Auth copyWith({
    String? username,
    String? role,
  }) {
    return Auth(
      username: username ?? this.username,
    );
  }
}
