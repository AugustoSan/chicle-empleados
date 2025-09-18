
import 'package:chicle_app_empleados/domain/domain.dart';

abstract class AuthRepository {
  /// Inicializa el repositorio.
  Future<void> initialize();
  /// Devuelve el nombre de usuario si hay sesión activa, o null si no.
  Future<Auth?> getLoggedInUser();

  /// Valida la contraseña.
  Future<bool> validatePassword(String username, String password);

  /// Intenta loguear; devuelve true si tuvo éxito.
  Future<bool> login(String username, String password);

  /// Cierra sesión.
  Future<void> logout();

  /// Cambia la contraseña (requiere contraseña actual).
  Future<bool> changePassword({
    required String username,
    required String currentPassword,
    required String newPassword,
  });

  /// Cambia solo el nombre (sin tocar el hash).
  Future<bool> changeUsername({
    required String username,
    required String newUsername,
  });

  /// Cambia solo el rol (sin tocar el hash).
  Future<bool> changeRole({
    required String username,
    required EnumRole newRole,
  });

  /// Añade un nuevo usuario.
  Future<bool> addUser({
    required String username,
    required String password,
    required EnumRole role,
  });

  /// Elimina un usuario.
  Future<bool> deleteUser({
    required String username,
  });

  Future<List<Auth>> getAllUsers();
}