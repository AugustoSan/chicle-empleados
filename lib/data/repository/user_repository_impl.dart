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
          email: 'admin@example.com', // o lo que prefieras
          password: hash,
        ),
      );
    }
  }

  @override
  Future<User?> getUser(String username) async {
    List<User> list = await getAllUsers();
    for (User user in list) {
      print(user.userName);
    }
    final query = _db.select(_db.usersModel)
      ..where((u) => u.name.equals(username));
    final row = await query.getSingleOrNull();
    if (row == null) return null;

    return User(
      userName:     row.name,
      passwordHash: row.password,
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
      userName: row.name,
      passwordHash: row.password,
    )).toList();
  }
}
