import '../entities/user.dart';

abstract class UserRepository {
  Future<void> initialize();
  Future<List<User>> getAllUsers();
  Future<User?> findUserById(String id);
  Future<User?> findUserByUsername(String username);
  Future<bool> changeUsername({
    required String id, 
    required String newUsername,
  });
  Future<bool> addUser(User user);
  Future<bool> updateUser({
    required String id, 
    required User user
  });
  Future<bool> deleteUser(String id);
  Future<bool> changePassword({
    required String id,
    required String currentPassword,
    required String newPassword,
  });
}