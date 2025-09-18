class Auth {
  final String username;      
  final String password;            
  final String role;

  Auth({
    required this.username,
    required this.password,
    required this.role,
  });

  Auth copyWith({
    String? username,
    String? password,
    String? role,
  }) {
    return Auth(
      username: username ?? this.username,
      password: password ?? this.password,
      role:     role     ?? this.role
    );
  }
}
