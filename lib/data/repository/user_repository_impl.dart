import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/models/models.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../services/auth_service.dart';

/// Contrato que define cómo obtener y guardar la configuración del negocio.
class UserRepositoryImpl implements UserRepository {
  static const _USERS_BOX   = Boxes.usersBox;
  static const _AUTH_BOX = Boxes.authBox;
  static const _AUTH_KEY    = Boxes.authKey;

  UserRepositoryImpl();
  // AuthRepositoryImpl();

  Future<Box<UserModel>> _openUsersBox() async {
    if(Hive.isBoxOpen(_USERS_BOX)) return await Hive.openBox<UserModel>(_USERS_BOX);
    return await Hive.openBox<UserModel>(_USERS_BOX);
  }

  Future<Box<String>> _openLoginBox() async {
    if(Hive.isBoxOpen(_AUTH_BOX)) return await Hive.openBox<String>(_AUTH_BOX);
    return await Hive.openBox<String>(_AUTH_BOX);
  }

  Future<User?> getUserLogin() async {
    final meta = await _openLoginBox();
    final username = meta.get(_AUTH_KEY);
    if (username == null) return null;

    final users = await _openUsersBox();
    final user = users.get(username);
    if (user == null) return null;
    return User(
      id: user.id,
      username: user.username,
      password: user.passwordHash,
      role: EnumRole.values[user.role],
    );
  }

  @override
  Future<void> initialize() async {
    final box = await _openUsersBox();
    // box.clear();
    if (box.isEmpty) {
      final username = 'admin';
      final passwordHash = AuthService.hashPassword(username);

      await addUser(
        User(
          username: username,
          password: passwordHash,
          role: EnumRole.administrador,
        )
      );
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    final users = await _openUsersBox();
    return users.values.map((user) => User.fromModel(user)).toList();
  }

  @override
  Future<User?> findUserById(String id) async {
    final box = await _openUsersBox();

  // Usa box.get() para obtener el UserModel por su clave (el ID)
  final userModel = box.get(id);

  if (userModel != null) {
    return User.fromModel(userModel);
  }
  return null; // No se encontró ningún usuario con ese ID
  }

  @override
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

  /// Cambia solo el nombre (sin tocar el hash).
  /// 
  @override
  Future<bool> changeUsername({
    required String id,
    required String newUsername,
  }) async {
    final user = await findUserById(id);
    final findUsername = await findUserByUsername(newUsername);
    if (findUsername != null) return false;
    if (user == null) return false;

    user.username = newUsername.trim();
    return await _saveUser(user);
  }

  /// Cambia la contraseña (requiere contraseña actual).
  @override
  Future<bool> changePassword({
    required String id,
    required String currentPassword,
    required String newPassword,
  }) async {
    final users = await _openUsersBox();
    final user = users.get(id);
    if (user == null) return false;

    final ok = user.passwordHash == AuthService.hashPassword(currentPassword);
    if (!ok) return false;

    user.passwordHash = AuthService.hashPassword(newPassword);
    await user.save();
    return true;
  }

  @override
  Future<bool> addUser(User newUser) async {
    final exists = await findUserByUsername(newUser.username);
    if (exists != null) return false;

    final id = Uuid().v4();
    final model = UserModel(
      id: id,
      username: newUser.username,
      passwordHash: newUser.password,
      role: newUser.role.index,
    );

    final box = await _openUsersBox();

    await box.put(id, model);

    return true;
  }

  @override
  Future<bool> updateUser({required String id, required User user}) async {
    final exists = await findUserById(id);
    if (exists == null) return false;
    await _saveUser(user);
    return true;
  }

  /// Elimina un usuario.
  @override
  Future<bool> deleteUser(String id) async {
    final users = await _openUsersBox();
    final userLogin = await getUserLogin();
    if (userLogin != null && userLogin.id == id) return false;
    await users.delete(id);
    return true;
  }

  Future<bool> _saveUser(User user) async {
    final users = await _openUsersBox();
    final exists = await findUserById(user.id);
    if (exists == null) return false;
    
    final model = UserModel(
      id: user.id,
      username: user.username,
      passwordHash: user.password,
      role: user.role.index,
    );
    await users.put(user.id, model);
    return true;
  }

}
