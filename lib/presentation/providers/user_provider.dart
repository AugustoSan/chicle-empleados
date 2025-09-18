// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _repo;
  final AuthProvider _auth;
  bool   _initialized = false;
  User? _currentUser;

  UserProvider(this._repo, this._auth);

  User? get currentUser => _currentUser;

  Future<void> initialize() async {
    if (_initialized) return;
    await _repo.initialize();
    _initialized = true;
  }

  Future<User?> getCurrentUser() async {
    final username = _auth.username;
    final user = await _repo.getUser(username);
    notifyListeners();
    _currentUser = user;
    return user;
  }

  Future<User?> getUser(String username) async {
    final user = await _repo.getUser(username);
    notifyListeners();
    return user;
  }

  Future<bool> validatePassword(String username, String password) async {
    return await _repo.validatePassword(username, password);
  }

  Future<bool> saveName(int id, String name) async {
    await _repo.changeName(id, name);
    notifyListeners();
    return true;
  }
  Future<bool> savePassword(int id, String currentPassword, String newPassword) async {
    await _repo.changePassword(id, currentPassword, newPassword);
    notifyListeners();
    return true;
  }

  Future<List<User>> getAllUsers() async {
    return await _repo.getAllUsers();
  }
}
