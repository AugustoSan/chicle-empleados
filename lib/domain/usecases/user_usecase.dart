import 'package:chicle_app_empleados/domain/domain.dart';

import '../../data/data.dart';

class InitializeUserUseCase{
  final UserRepositoryImpl repository;

  InitializeUserUseCase(this.repository);

  Future<void> call() => repository.initialize();
}

class GetAllUsersUseCase{
  final UserRepositoryImpl repository;

  GetAllUsersUseCase(this.repository);

  Future<List<User>> call() {
    return repository.getAllUsers();
  }
}

class GetUserByIdUseCase {
  final UserRepositoryImpl repository;

  GetUserByIdUseCase(this.repository);

  Future<User?> call(String id) {
    return repository.findUserById(id);
  }
}

class GetUserByUsernameUseCase {
  final UserRepositoryImpl repository;

  GetUserByUsernameUseCase(this.repository);

  Future<User?> call(String username) {
    return repository.findUserByUsername(username);
  }
}

class ChangeUsernameUseCase {
  final UserRepositoryImpl repository;

  ChangeUsernameUseCase(this.repository);

  Future<bool?> call(String id, String newUsername){
    return repository.changeUsername(id: id, newUsername: newUsername);
  }
}

class ChangePasswordUseCase {
  final UserRepositoryImpl repository;

  ChangePasswordUseCase(this.repository);

  Future<bool?> call(String id, String currentPassword, String newPassword){
    return repository.changePassword(id: id, currentPassword: currentPassword, newPassword: newPassword);
  }
}

class AddUserUseCase {
  final UserRepositoryImpl repository;

  AddUserUseCase(this.repository);

  Future<bool> call(User user) {
    return repository.addUser(user);
  }
}

class UpdateUserUseCase {
  final UserRepositoryImpl repository;

  UpdateUserUseCase(this.repository);

  Future<bool> call(String id, User user) {
    return repository.updateUser(id: id, user: user);
  }
}

class DeleteUserUseCase{
  final UserRepositoryImpl repository;

  DeleteUserUseCase(this.repository);

  Future<bool> call(String id) {
    return repository.deleteUser(id);
  }
}
