// import 'package:flutter/material.dart';
// import '../../domain/domain.dart';

// class AuthProvider with ChangeNotifier {
//   final AuthRepository _auth;

//   bool   _isLoggedIn = false;
//   String _username   = '';
//   String _role       = '';

//   AuthProvider(this._auth);

//   bool get isLoggedIn => _isLoggedIn;
//   String get username => _username;
//   String get role     => _role;

//   Future<void> initialize() async {
//     await _auth.initialize();
//   }

//   Future<void> checkLogin() async {
//     final user = await _auth.getLoggedInUser();
//     _username   = user?.username ?? '';
//     _role       = user?.role ?? '';
//     _isLoggedIn = user != null;
//     notifyListeners();
//   }

//   Future<bool> login(String username, String password) async {
//     final ok = await _auth.login(username, password);
//     if (ok) {
//       final user = await _auth.getLoggedInUser();
//       _username   = user?.username ?? '';
//       _role       = user?.role ?? '';
//       _isLoggedIn = true;
//       notifyListeners();
//     }
//     return ok;
//   }

//   Future<bool> validatePassword(String username, String password) async {
//     return await _auth.validatePassword(username, password);
//   }

//   Future<void> logout() async {
//     await _auth.logout();
//     _username   = '';
//     _isLoggedIn = false;
//     notifyListeners();
//   }

//   Future<bool> changePassword({
//     required String currentPassword,
//     required String newPassword,
//   }) async {
//     final ok = await _auth.changePassword(
//       username: _username,
//       currentPassword: currentPassword,
//       newPassword: newPassword,
//     );
//     if (ok) {
//       notifyListeners();
//     }
//     return ok;
//   }

//   Future<bool> changeUsername({
//     required String newUsername,
//   }) async {
//     final ok = await _auth.changeUsername(
//       username: _username,
//       newUsername: newUsername,
//     );
//     if (ok) {
//       _username = newUsername;
//       notifyListeners();
//     }
//     return ok;
//   }

//   Future<bool> changeRole({
//     required EnumRole newRole,
//   }) async {
//     final ok = await _auth.changeRole(
//       username: _username,
//       newRole: newRole,
//     );
//     if (ok) {
//       _role = newRole.name;
//       notifyListeners();
//     }
//     return ok;
//   }

//   Future<List<Auth>> getAllUsers() async {
//     return await _auth.getAllUsers();
//   }

//   Future<bool> addUser({
//     required String username,
//     required String password,
//     required EnumRole role,
//   }) async {
//     final ok = await _auth.addUser(
//       username: username,
//       password: password,
//       role: role,
//     );
//     if (ok) {
//       notifyListeners();
//     }
//     return ok;
//   }

//   Future<bool> deleteUser({
//     required String username,
//   }) async {
//     final ok = await _auth.deleteUser(
//       username: username,
//     );
//     if (ok) {
//       notifyListeners();
//     }
//     return ok;
//   }
// }
