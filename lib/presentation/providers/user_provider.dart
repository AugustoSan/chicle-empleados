// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _repo;
  final AuthRepository _auth;

  UserProvider(this._repo, this._auth);

  Future<void> initialize() async {
    await _repo.initialize();
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final currentUser = await _auth.getUserLogin();
    if (currentUser == null) return false;
    final ok = await _repo.changePassword(
      id: currentUser.id,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    if (ok) {
      notifyListeners();
    }
    return ok;
  }

  Future<bool> changeUsername({
    required String newUsername,
  }) async {
    final currentUser = await _auth.getUserLogin();
    if (currentUser == null) return false;
    final ok = await _repo.changeUsername(
      id: currentUser.id,
      newUsername: newUsername,
    );
    if (ok) {
      notifyListeners();
    }
    return ok;
  }

  Future<bool> changeRole({
    required String id,
    required EnumRole newRole,
  }) async {
    final user = await _repo.findUserById(id);
    if ( user == null) return false;
    user.role = newRole;
    final ok = await _repo.updateUser(
      id: id,
      user: user,
    );
    if (ok) {
      notifyListeners();
    }
    return ok;
  }

  Future<List<User>> getAllUsers() async {
    return await _repo.getAllUsers();
  }

  Future<User?> findUserById(String id) async {
    return await _repo.findUserById(id);
  }

  Future<User?> findUserByUsername(String username) async {
    return await _repo.findUserByUsername(username);
  }

  Future<bool> addUser({
    required String username,
    required String password,
    required EnumRole role,
  }) async {
    final ok = await _repo.addUser(
      User(
        username: username,
        password: password,
        role: role,
      )
    );
    if (ok) {
      notifyListeners();
    }
    return ok;
  }

  Future<bool> deleteUser({
    required User user,
  }) async {
    final ok = await _repo.deleteUser(
      user.id,
    );
    if (ok) {
      notifyListeners();
    }
    return ok;
  }



  Future<User?> getCurrentUser() async {
    return await _auth.getUserLogin();
  }

  Future<User?> GetUserById(String id) async {
    final user = await _repo.findUserById(id);
    notifyListeners();
    return user;
  }

  Future<User?> getUserByUsername(String username) async {
    final user = await _repo.findUserByUsername(username);
    notifyListeners();
    return user;
  }

  // Future<bool> validatePassword(String username, String password) async {
  //   return await _repo.validatePassword(username, password);
  // }

}
