class User {
  late int id;
  late String username;                // Nombre del usuario

  User({
    required this.id,
    required this.username,
  });

  User.withoutId({
    required this.username,
  }) {
    id = -1;
  }
  User.empty() {
    id = -1;
    username = 'sin nombre de usuario';
  }
}