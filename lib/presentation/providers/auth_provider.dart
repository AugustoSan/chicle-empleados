import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _repo;

  bool   _isLoggedIn = false;
  String _username   = '';

  AuthProvider(this._repo);

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;

  Future<void> checkLogin() async {
    final user = await _repo.getLoggedInUser();
    _username   = user ?? '';
    _isLoggedIn = user != null;
    notifyListeners();
  }

  Future<bool> login(String name, String password) async {
    final ok = await _repo.login(name, password);
    if (ok) {
      _username   = name;
      _isLoggedIn = true;
      notifyListeners();
    }
    return ok;
  }

  Future<void> logout() async {
    await _repo.logout();
    _username   = '';
    _isLoggedIn = false;
    notifyListeners();
  }
}
