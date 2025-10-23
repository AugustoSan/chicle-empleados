import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/models/models.dart';
import 'package:hive/hive.dart';
import '../services/auth_service.dart';

/// Contrato que define cómo obtener y guardar la configuración del negocio.
class AuthRepositoryImpl implements AuthRepository {
  static const _AUTH_BOX = Boxes.authBox;
  static const _AUTH_KEY    = Boxes.authKey;
  static const _USERS_BOX   = Boxes.usersBox;

  AuthRepositoryImpl();
  // AuthRepositoryImpl();

  Future<Box<UserModel>> _openUsersBox() async {
    if(Hive.isBoxOpen(_USERS_BOX)) return await Hive.openBox<UserModel>(_USERS_BOX);
    return await Hive.openBox<UserModel>(_USERS_BOX);
  }

  Future<Box<String>> _openLoginBox() async {
    if(Hive.isBoxOpen(_AUTH_BOX)) return await Hive.openBox<String>(_AUTH_BOX);
    return await Hive.openBox<String>(_AUTH_BOX);
  }

  @override
  Future<User?> getUserLogin() async {
    final meta = await _openLoginBox();
    final username = meta.get(_AUTH_KEY);
    if (username == null) return null;

    return await findUserByUsername(username);
  }

  @override
  Future<bool> login(String username, String password) async {
    final user = await findUserByUsername(username);
    if (user == null) return false;
    final passwordHash = AuthService.checkPassword(password, user.password);
    final ok = passwordHash;
    if (ok) {
      final authBox = await _openLoginBox();
      await authBox.put(_AUTH_KEY, username);
    }
    return ok;
  }

  @override
  Future<void> logout() async {
    final box = await _openLoginBox();
    await box.delete(_AUTH_KEY);
  }

  Future<User?> findUserByUsername(String username) async {
    final box = await _openUsersBox();

    // Filtra los usuarios que coinciden
    final matchingUsers = box.values.where(
      (model) => model.username.toLowerCase() == username.toLowerCase(),
    );

    // Toma el primero o null si la colección filtrada está vacía
    final userModel = matchingUsers.firstOrNull; // Disponible en Iterable (y List) desde Dart 2.17

    // Si se encuentra, conviértelo de UserModel a tu entidad de Dominio User
    if (userModel != null) {
      return User.fromModel(userModel);
    }
    return null; // No se encontró ningún usuario con ese username
  }
}
