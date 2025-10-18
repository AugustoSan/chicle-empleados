// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _repo;
  final AuthProvider _auth;
  User? _currentUser;

  UserProvider(this._repo, this._auth);

  User? get currentUser => _currentUser;

  Future<User?> getCurrentUser() async {
    final username = _auth.username;
    final user = await _repo.getUserDB(username);
    notifyListeners();
    _currentUser = user;
    return user;
  }

  Future<User?> getUser(String username) async {
    final user = await _repo.getUserDB(username);
    notifyListeners();
    return user;
  }

  // Future<bool> validatePassword(String username, String password) async {
  //   return await _repo.validatePassword(username, password);
  // }

  Future<bool> saveUsername(int id, String username) async {
    await _repo.changeUsernameDB(id, username);
    notifyListeners();
    return true;
  }

  Future<List<User>> getAllUsers() async {
    return await _repo.getAllUsersDB();
  }

  Future<bool> deleteUserDB(String username) async {
    final result = await _repo.deleteUserDB(username);
    notifyListeners();
    return result;
  }
}
