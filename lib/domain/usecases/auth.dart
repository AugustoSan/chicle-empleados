import 'package:chicle_app_empleados/domain/domain.dart';

class LoginUseCase {
  final AuthRepository repo;
  LoginUseCase(this.repo);
  Future<void> call(String username, String password) => repo.login(username, password);
}

class LogoutUseCase {
  final AuthRepository repo;
  LogoutUseCase(this.repo);
  Future<void> call() => repo.logout();
}

class GetUserLoginUseCase {
  final AuthRepository repo;
  GetUserLoginUseCase(this.repo);
  Future<User?> call() => repo.getUserLogin();
}

// class ChangePassword {
//   final AuthRepository repo;
//   ChangePassword(this.repo);
//   Future<bool> call({
//     required String username,
//     required String currentPassword,
//     required String newPassword,
//   }) => repo.changePassword(
//     username: username,
//     currentPassword: currentPassword,
//     newPassword: newPassword,
//   );
// }

// class ChangeUsername {
//   final AuthRepository repo;
//   ChangeUsername(this.repo);
//   Future<bool> call({
//     required String username,
//     required String newUsername,
//   }) => repo.changeUsername(
//     username: username,
//     newUsername: newUsername,
//   );
// }

// class ChangeRole {
//   final AuthRepository repo;
//   ChangeRole(this.repo);
//   Future<bool> call({
//     required String username,
//     required EnumRole newRole,
//   }) => repo.changeRole(
//     username: username,
//     newRole: newRole,
//   );
// }

// class AddUser {
//   final AuthRepository repo;
//   AddUser(this.repo);
//   Future<bool> call({
//     required String username,
//     required String password,
//     required EnumRole role,
//   }) => repo.addUser(
//     username: username,
//     password: password,
//     role: role,
//   );
// }

// class DeleteUser {
//   final AuthRepository repo;
//   DeleteUser(this.repo);
//   Future<bool> call({
//     required String username,
//   }) => repo.deleteUser(
//     username: username,
//   );
// }
