import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _auth;

  bool   _isLoggedIn = false;
  User? _user;
  bool _isAdmin       = false;

  AuthProvider(this._auth);

  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user;
  bool get isAdmin     => _isAdmin;

  Future<void> checkLogin() async {
    final user = await _auth.getUserLogin();
    _user   = user;
    _isAdmin    = user?.role == EnumRole.administrador;
    _isLoggedIn = user != null;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    final ok = await _auth.login(username, password);
    if (ok) {
      final user = await _auth.getUserLogin();
      _user   = user;
      _isAdmin    = user?.role == EnumRole.administrador;
      _isLoggedIn = true;
      notifyListeners();
    }
    return ok;
  }

  Future<void> logout() async {
    await _auth.logout();
    _user   = null;
    _isAdmin    = false;
    _isLoggedIn = false;
    notifyListeners();
  }
}
