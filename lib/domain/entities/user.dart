class User {
  final String userName;                // Nombre del local
  final String passwordHash;            // Ej: "MXN", "USD"

  User({
    required this.userName,
    required this.passwordHash,
  });
}