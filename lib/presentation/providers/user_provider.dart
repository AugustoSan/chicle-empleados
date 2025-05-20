// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _repo;
  bool   _initialized = false;
  User?  _currentUser;

  UserProvider(this._repo);

  Future<void> initialize() async {
    if (_initialized) return;
    await _repo.initialize();
    _initialized = true;
  }

  Future<User?> getUser(String username) async {
    final user = await _repo.getUser(username);
    notifyListeners();
    return user;
  }

  Future<bool> validatePassword(String username, String password) async {
    return await _repo.validatePassword(username, password);
  }

  User? get currentUser => _currentUser;

  Future<bool> saveUser(User user) async {
    await _repo.saveUser(user);
    notifyListeners();
    return true;
  }

  Future<List<User>> getAllUsers() async {
    return await _repo.getAllUsers();
  }
}
