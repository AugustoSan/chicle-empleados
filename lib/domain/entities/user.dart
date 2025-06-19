class User {
  late int id;
  late String name;
  late String username;                // Nombre del usuario
  late String passwordHash;            // Hash de la contraseña
  late String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.passwordHash,
    required this.imageUrl,
  });

  User.withoutId({
    required this.name,
    required this.username,
    required this.passwordHash,
    required this.imageUrl,
  }) {
    id = -1;
  }
  User.empty() {
    id = -1;
    name = 'sin nombre';
    username = 'sin nombre';
    passwordHash = 'sin contraseña';
    imageUrl = '';
  }
}