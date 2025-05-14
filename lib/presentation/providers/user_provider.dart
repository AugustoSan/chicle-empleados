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
    _currentUser = await _repo.getUser(username);
    notifyListeners();
    return _currentUser;
  }

  Future<bool> validatePassword(String username, String password) async {
    return await _repo.validatePassword(username, password);
  }

  User? get currentUser => _currentUser;

  // Future<void> saveUser(User user) async {
  //   _user = user;
  //   await _repo.saveUser(user);
  //   notifyListeners();
  // }
}
