import 'dart:convert';

import 'package:chicle_app_empleados/data/services/api_service.dart';
import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/models/models.dart';
import 'package:chicle_app_empleados/data/datasource/hive_data_source.dart';
// import 'package:hive/hive.dart';
import '../services/auth_service.dart';

/// Contrato que define cómo obtener y guardar la configuración del negocio.
class AuthRepositoryImpl implements AuthRepository {
  static const _AUTH_BOX = Boxes.authBox;
  static const _AUTH_KEY    = Boxes.authKey;
  static const _USERS_BOX   = Boxes.usersBox;
  final HiveDataSource _hiveDataSource;

  AuthRepositoryImpl(this._hiveDataSource);

  @override
  Future<User?> getUserLogin() async {
    final meta = await _hiveDataSource.openBox<String>(_AUTH_BOX);
    final username = meta.get(_AUTH_KEY);
    if (username == null) return null;

    return await findUserByUsername(username);
  }

  @override
  Future<bool> login(String username, String password) async {
    final user = await findUserByUsername(username);
    final test = await _fetchLogin(username, password);
    print('test: $test');
    if (user == null) return false;
    final passwordHash = AuthService.checkPassword(password, user.password);
    final ok = passwordHash;
    if (ok) {
      final authBox = await _hiveDataSource.openBox<String>(_AUTH_BOX);
      await authBox.put(_AUTH_KEY, username);
    }
    return ok;
  }

  @override
  Future<void> logout() async {
    final box = await _hiveDataSource.openBox<String>(_AUTH_BOX);
    await box.delete(_AUTH_KEY);
  }

  Future<AuthApi?> _fetchLogin(String username, String password) async {
    final response = await ApiService.post('Auth', body: {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return AuthApi.fromJson(jsonResponse);
    } else {
      print('Failed to load menu. Status Code: ${response.statusCode}');
      return null;
    }
    
  }

  Future<User?> findUserByUsername(String username) async {
    final box = await _hiveDataSource.openBox<UserModel>(_USERS_BOX);

    // Filtra los usuarios que coinciden
    final matchingUsers = box.values.where(
      (model) => model.username.toLowerCase() == username.toLowerCase(),
    );

    // Toma el primero o null si la colección filtrada está vacía
    final userModel = matchingUsers.firstOrNull; // Disponible en Iterable (y List) desde Dart 2.17

    // Si se encuentra, conviértelo de UserModel a tu entidad de Dominio User
    if (userModel != null) {
      return User.fromModel(userModel);
    }
    return null; // No se encontró ningún usuario con ese username
  }
}
