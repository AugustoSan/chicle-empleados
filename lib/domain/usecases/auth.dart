import '../../domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository repo;
  Login(this.repo);
  Future<void> call(String name, String password) => repo.login(name, password);
}

class Logout {
  final AuthRepository repo;
  Logout(this.repo);
  Future<void> call() => repo.logout();
}

class GetLoggedInUser {
  final AuthRepository repo;
  GetLoggedInUser(this.repo);
  Future<String?> call() => repo.getLoggedInUser();
}


