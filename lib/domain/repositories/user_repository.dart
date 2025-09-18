import '../entities/user.dart';

abstract class UserRepository {
  Future<User?> getUserDB(String username);
  Future<bool> changeUsernameDB(int id, String username);
  Future<List<User>> getAllUsersDB();
  Future<bool> addUserDB(String username);
  Future<bool> deleteUserDB(String username);
  Future<User?> findUserByIdDB(int id);
  Future<User?> findUserByUsernameDB(String username);
}