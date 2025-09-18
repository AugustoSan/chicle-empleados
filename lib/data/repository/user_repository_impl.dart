import 'package:drift/drift.dart';

import '../../data/local/app_database.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../data/services/auth_service.dart';

class UserRepositoryImpl implements UserRepository {
  final AppDatabase _db;

  UserRepositoryImpl(this._db);

  @override
  Future<void> initialize() async {
    // Si no hay usuarios, creamos uno por defecto
    final existing = await _db.select(_db.usersModel).get();
    if (existing.isEmpty) {
      final hash = AuthService.hashPassword('admin');
      await _db.into(_db.usersModel).insert(
        UsersModelCompanion.insert(
          name: 'admin',
          username: 'admin',
          password: hash,
          imageUrl: '',
        ),
      );
    }
  }

  @override
  Future<User?> getUser(String username) async {
    List<User> list = await getAllUsers();
    final user = list.where((us) => us.username == username).firstOrNull;
    if (user == null) return null;

    return User(
      id: user.id,
      name: user.name,
      username: user.username,
      passwordHash: user.passwordHash,
      imageUrl: user.imageUrl,
    );
  }

  @override
  Future<bool> validatePassword(String username, String password) async {
    final user = await getUser(username);
    return user != null && user.passwordHash == AuthService.hashPassword(password);
  }

  @override
  Future<List<User>> getAllUsers() async {
    final query = _db.select(_db.usersModel);
    final rows = await query.get();
    return rows.map((row) => User(
      id: row.id,
      name: row.name,
      username: row.username,
      passwordHash: row.password,
      imageUrl: row.imageUrl,
    )).toList();
  }

  @override
  Future<bool> changeName(int id, String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return false;

    final user = await findUserById(id);
    if (user == null) return false;

    final rows = await (_db.update(_db.usersModel)
        ..where((t) => t.id.equals(id)))
      .write(UsersModelCompanion(name: Value(trimmed)));

    return rows > 0;
  }

  @override
  Future<bool> changePassword(int id, String currentPassword, String newPassword) async {
    final trimmed = newPassword.trim();
    if (trimmed.isEmpty) return false;

    final user = await findUserById(id);
    if (user == null) return false;

    final currentHash = AuthService.hashPassword(currentPassword);
    if (currentHash != user.passwordHash) return false;
    
    final rows = await (_db.update(_db.usersModel)
        ..where((t) => t.id.equals(id)))
      .write(UsersModelCompanion(name: Value(trimmed)));

    return rows > 0;
  }

  Future<User?> findUserById(int id) async {
    List<User> list = await getAllUsers();
    final user = list.where((us) => us.id == id).firstOrNull;
    if (user == null) return null;
    return User(
      id: user.id,
      name: user.name,
      username: user.username,
      passwordHash: user.passwordHash,
      imageUrl: user.imageUrl,
    );
  }
}
