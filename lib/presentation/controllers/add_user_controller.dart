import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class AddUserController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  final ValueNotifier<EnumRole> role = ValueNotifier<EnumRole>(EnumRole.usuario);

  bool  _loading = false;
  String? _error;
  bool  get loading => _loading;
  String? get error => _error;

  final UserProvider _userProvider;

  AddUserController(this._userProvider);

  Future<String> save(BuildContext context) async {
    
    final error = validate();
    if (error != '') {
      _error = error;
      return error;
    }
    _loading = true;
    _error   = null;
    notifyListeners();

    final ok = await _userProvider.addUser(username: usernameC.text, password: passwordC.text, role: role.value);
    if (!ok) {
      _error = 'Ocurrio un error al guardar';
      return _error!;
    }
    _loading = false;
    notifyListeners();
    return error;
  }

  String validate() {
    if(usernameC.text.isEmpty) return 'Nombre de usuario inválido';
    if(passwordC.text.isEmpty) return 'Contraseña inválida';
    return '';
  }

  @override
  void dispose() {
    usernameC.dispose();
    passwordC.dispose();
    role.dispose();
    super.dispose();
  }
}
