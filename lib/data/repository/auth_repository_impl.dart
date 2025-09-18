import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/models/models.dart';
import 'package:hive/hive.dart';
import '../services/auth_service.dart';

/// Contrato que define cómo obtener y guardar la configuración del negocio.
class AuthRepositoryImpl implements AuthRepository {
  static const _AUTH_BOX    = Boxes.authBox;
  static const _AUTH_KEY    = Boxes.key;
  static const _USERS_BOX   = Boxes.usersBox;

  final UserRepository _userRepository;

  AuthRepositoryImpl(this._userRepository);
  // AuthRepositoryImpl();

  Future<Box<AuthModel>> _usersBox() async {
    if(Hive.isBoxOpen(_USERS_BOX)) return await Hive.openBox<AuthModel>(_USERS_BOX);
    return await Hive.openBox<AuthModel>(_USERS_BOX);
  }

  Future<Box<String>> _authBox() async {
    if(Hive.isBoxOpen(_AUTH_BOX)) return await Hive.openBox<String>(_AUTH_BOX);
    return await Hive.openBox<String>(_AUTH_BOX);
  }

  @override
  Future<void> initialize() async {
    final box = await _usersBox();
    // box.clear();
    if (box.isEmpty) {
      final username = 'admin';
      await addUser(
        username: username,
        password: username,
        role: EnumRole.administrador,
      );
      await _userRepository.addUserDB(username);
    }
  }

  @override
  Future<Auth?> getLoggedInUser() async {
    final meta = await _authBox();
    final username = meta.get(_AUTH_KEY);
    if (username == null) return null;

    final users = await _usersBox();
    final user = users.get(username);
    if (user == null) return null;
    return Auth(
      username: user.username,
      password: user.password,
      role: user.role,
    );
  }

  @override
  Future<bool> validatePassword(String username, String password) async {
    final users = await _usersBox();
    final user = users.get(username);
    if (user == null) return false;
    return user.password == AuthService.hashPassword(password);
  }

  @override
  Future<bool> login(String username, String password) async {
    final users = await _usersBox();
    final user = users.get(username);
    if (user == null) return false;

    final ok = user.password == AuthService.hashPassword(password);
    if (ok) {
      final authBox = await _authBox();
      await authBox.put(_AUTH_KEY, username);
    }
    return ok;
  }

  @override
  Future<void> logout() async {
    final box = await _authBox();
    await box.delete(_AUTH_KEY);
  }

  /// Cambia la contraseña (requiere contraseña actual).
  @override
  Future<bool> changePassword({
    required String username,
    required String currentPassword,
    required String newPassword,
  }) async {
    final users = await _usersBox();
    final user = users.get(username);
    if (user == null) return false;

    final ok = user.password == AuthService.hashPassword(currentPassword);
    if (!ok) return false;

    user.password = AuthService.hashPassword(newPassword);
    await user.save();
    return true;
  }

  /// Cambia solo el nombre (sin tocar el hash).
  /// 
  @override
  Future<bool> changeUsername({
    required String username,
    required String newUsername,
  }) async {
    final users = await _usersBox();
    final user = users.get(username);
    if (user == null) return false;

    final trimmed = newUsername.trim();
    if (trimmed.isEmpty || trimmed == username) return false;
    if (users.containsKey(trimmed)) return false;

    await deleteUserOnlyAuth(username: username);
    final model = AuthModel(
      username: trimmed,
      password: user.password,
      role: user.role,
    );
    await users.put(trimmed, model);
    logout();
    final userBD = await _userRepository.findUserByUsernameDB(username);
    if (userBD == null) return false;
    await _userRepository.changeUsernameDB(userBD.id, trimmed);
    return true;
  }

  /// Cambia solo el nombre (sin tocar el hash).
  @override
  Future<bool> changeRole({
    required String username,
    required EnumRole newRole,
  }) async {
    final users = await _usersBox();
    final user = users.get(username);
    if (user == null) return false;

    user.role = newRole.name;
    await user.save();
    logout();
    return true;
  }

  /// Elimina un usuario.
  @override
  Future<bool> addUser({
    required String username,
    required String password,
    required EnumRole role,
  }) async {
    final users = await _usersBox();
    final key = username.trim();
    if (key.isEmpty || users.containsKey(key)) return false;
    final exists = users.containsKey(key);
    if (exists) return false;

    final model = AuthModel(
      username: key,
      password: AuthService.hashPassword(password),
      role: role.name,
    );
    await users.put(key, model);

    await _userRepository.addUserDB(key);
    return true;
  }

  /// Elimina un usuario.
  @override
  Future<bool> deleteUser({
    required String username,
  }) async {
    final users = await _usersBox();
    if (!users.containsKey(username)) return false;
    await users.delete(username);
    await _userRepository.deleteUserDB(username);
    return true;
  }

  Future<bool> deleteUserOnlyAuth({
    required String username,
  }) async {
    final users = await _usersBox();
    if (!users.containsKey(username)) return false;
    await users.delete(username);
    return true;
  }

  @override
  Future<List<Auth>> getAllUsers() async {
    final users = await _usersBox();
    return users.values.map((user) => Auth(
      username: user.username,
      password: '',
      role: user.role,
    )).toList();
  }

}
