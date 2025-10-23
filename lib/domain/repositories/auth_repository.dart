
import 'package:chicle_app_empleados/domain/domain.dart';

abstract class AuthRepository {
  /// Devuelve el nombre de usuario si hay sesión activa, o null si no.
  Future<User?> getUserLogin();

  /// Intenta loguear; devuelve true si tuvo éxito.
  Future<bool> login(String username, String password);

  /// Cierra sesión.
  Future<void> logout();
}