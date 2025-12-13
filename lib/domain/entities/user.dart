import 'package:chicle_app_empleados/models/models.dart';
import 'package:uuid/uuid.dart';

import '../domain.dart'; // Asumo que EnumRole está aquí

class User {
  final String id; // El ID es final, solo tiene getter (implícito)

  // Queremos que el username sea modificable, así que no es 'final'.
  // Y queremos un setter con alguna lógica, así que usaremos una variable privada.
  late String _username;

  late String _password; // La contraseña es final, solo tiene getter (implícito)
  late EnumRole _role;     // El rol es final, solo tiene getter (implícito)


  User({
    String? id, // Hacer el 'id' opcional en el constructor principal si lo generas aquí
    required String username, // Recibirlo como parámetro normal
    required String password,
    required EnumRole role,
  }) : this.id = id ?? const Uuid().v4() { // Genera un ID si no se proporciona
    this._username = username;
    this._password = password;
    this._role = role; // Usa el setter para inicializar _username
  }

  // --- Getters ---
  // El getter para 'id', 'password', 'role' es implícito porque son 'final'.
  // Para 'username', necesitamos un getter que acceda a la variable privada.
  String get username => _username;
  String get password => _password;
  EnumRole get role => _role;

  // --- Setters ---
  // Setter para 'username' con lógica de validación o transformación.
  set username(String value) {
    if (value.trim().isEmpty) {
      throw ArgumentError('El nombre de usuario no puede estar vacío.');
    }
    _username = value.trim(); // Guarda el nombre de usuario limpio de espacios
  }

  // Setter para 'password' con lógica de validación o transformación.
  set password(String value) {
    if (value.trim().isEmpty) {
      throw ArgumentError('La contraseña no puede estar vacía.');
    }
    _password = password.trim(); // Guarda el nombre de usuario limpio de espacios
  }

  set role(EnumRole value) {
    _role = value;
  }



  User.fromModel(UserModel model) :
    id = model.id,
    _username = model.username,
    _password = model.passwordHash,
    _role = EnumRole.values[model.role];

  UserModel parseToModel() => UserModel(
    id: id,
    username: _username,
    passwordHash: _password,
    role: role.index,
  );

  User.empty() :
    id = const Uuid().v4(),
    _username = '',
    _password = '',
    _role = EnumRole.usuario;

  // Puedes añadir otros getters calculados si los necesitas, por ejemplo:
  bool get isAdmin => role == EnumRole.administrador;
  
}