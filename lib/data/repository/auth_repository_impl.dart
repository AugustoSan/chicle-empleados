import 'package:hive/hive.dart';
import '../local/app_database.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/auth_service.dart';
import '../../domain/entities/boxes.dart';

/// Contrato que define cómo obtener y guardar la configuración del negocio.
class AuthRepositoryImpl implements AuthRepository {
  static const _AUTH_BOX    = Boxes.authBox;
  static const _AUTH_KEY    = Boxes.key;

  final AppDatabase _db;

  AuthRepositoryImpl(this._db);

  @override
  Future<String?> getLoggedInUser() async {
    final box = await Hive.openBox<String>(_AUTH_BOX);
    final user = box.get(_AUTH_KEY);
    return user != null && user.isNotEmpty ? user : null;
  }

  @override
  Future<bool> login(String username, String password) async {
    final query = _db.select(_db.usersModel)
        ..where((u) => u.name.equals(username));
    final user = await query.getSingleOrNull();

    if (user != null && AuthService.verifyPassword(password, user.password)) {
      final authBox = await Hive.openBox<String>(_AUTH_BOX);
      await authBox.put(_AUTH_KEY, username);
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    final box = await Hive.openBox<String>(_AUTH_BOX);
    await box.delete(_AUTH_KEY);
  }
}
