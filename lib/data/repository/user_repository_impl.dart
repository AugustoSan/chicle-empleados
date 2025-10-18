import 'package:drift/drift.dart';

import '../../data/local/app_database.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final AppDatabase _db;

  UserRepositoryImpl(this._db);

  @override
  Future<User?> getUserDB(String username) async {
    List<User> list = await getAllUsersDB();
    final user = list.where((us) => us.username == username).firstOrNull;
    if (user == null) return null;

    return User(
      id: user.id,
      username: user.username,
    );
  }

  @override
  Future<bool> changeUsernameDB(int id, String username) async {
    final trimmed = username.trim();
    if (trimmed.isEmpty) return false;

    final user = await findUserByIdDB(id);
    if (user == null) return false;

    final rows = await (_db.update(_db.usersModel)
        ..where((t) => t.id.equals(id)))
      .write(UsersModelCompanion(username: Value(trimmed)));

    return rows > 0;
  }

  @override
  Future<List<User>> getAllUsersDB() async {
    final query = _db.select(_db.usersModel);
    final rows = await query.get();
    return rows.map((row) => User(
      id: row.id,
      username: row.username,
    )).toList();
  }

  @override
  Future<bool> addUserDB(String username) async {
    final rows = await _db.into(_db.usersModel).insert(UsersModelCompanion.insert(
      username: username,
    ));
    return rows > 0;
  }

  @override
  Future<bool> deleteUserDB(String username) async {
    final user = await findUserByUsernameDB(username);
    if (user == null) return false;
    final rows = await _db.delete(_db.usersModel).delete(UsersModelCompanion(
      id: Value(user.id),
      username: Value(username),
    ));
    return rows > 0;
  }

  @override
  Future<User?> findUserByIdDB(int id) async {
    List<User> list = await getAllUsersDB();
    final user = list.where((us) => us.id == id).firstOrNull;
    if (user == null) return null;
    return User(
      id: user.id,
      username: user.username,
    );
  }

  @override
  Future<User?> findUserByUsernameDB(String username) async {
    List<User> list = await getAllUsersDB();
    final user = list.where((us) => us.username == username).firstOrNull;
    if (user == null) return null;
    return User(
      id: user.id,
      username: user.username,
    );
  }

}
