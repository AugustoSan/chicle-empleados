class User {
  final int id;
  final String name;
  final String username;                // Nombre del usuario
  final String passwordHash;            // Hash de la contraseña
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.passwordHash,
    required this.imageUrl,
  });
}