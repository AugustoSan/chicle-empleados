import '../entities/user.dart';

abstract class UserRepository {
  Future<void> initialize();
  Future<User?> getUser(String username);
  Future<bool> changeName(int id, String name);
  Future<bool> changePassword(int id, String currentPassword, String newPassword);
  Future<List<User>> getAllUsers();
  Future<bool> validatePassword(String username, String password);
}