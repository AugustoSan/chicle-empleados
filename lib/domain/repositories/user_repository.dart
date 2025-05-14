import '../entities/user.dart';

abstract class UserRepository {
  Future<void> initialize();
  Future<User?> getUser(String username);
  Future<List<User>> getAllUsers();
  Future<bool> validatePassword(String username, String password);
}