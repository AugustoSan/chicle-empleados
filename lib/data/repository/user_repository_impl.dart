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
    for (User user in list) {
      print(user.username);
    }
    final query = _db.select(_db.usersModel)
      ..where((u) => u.name.equals(username));
    final row = await query.getSingleOrNull();
    if (row == null) return null;

    return User(
      id:           row.id,
      name:         row.name,
      username:     row.name,
      passwordHash: row.password,
      imageUrl:     row.imageUrl,
    );
  }

  @override
  Future<bool> validatePassword(String username, String password) async {
    final user = await getUser(username);
    return user != null && AuthService.verifyPassword(password, user.passwordHash);
  }

  @override
  Future<List<User>> getAllUsers() async {
    final query = _db.select(_db.usersModel);
    final rows = await query.get();
    return rows.map((row) => User(
      id:           row.id,
      name:         row.name,
      username:     row.name,
      passwordHash: row.password,
      imageUrl:     row.imageUrl,
    )).toList();
  }

  @override
  Future<bool> saveUser(User user) async {
    final companion = UsersModelCompanion(
      name: Value(user.name),
      username: Value(user.username),
      password: Value(user.passwordHash),
      imageUrl: Value(user.imageUrl),
    );
      
    // Ejecutamos el update y recogemos cuántas filas se vieron afectadas
    final rowsAffected = await (_db.update(_db.usersModel)
      ..where((tbl) => tbl.id.equals(user.id))
    ).write(companion);

    // Devolvemos true si al menos una fila fue actualizada
    return rowsAffected > 0;
  }
}
