import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import '../providers/providers.dart';

class LoginController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool  _loading = false;
  String? _error;
  bool  get loading => _loading;
  String? get error => _error;

  final AuthProvider _auth;

  LoginController(this._auth);

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    _loading = true;
    _error   = null;
    notifyListeners();

    final ok = await _auth.login(
      usernameController.text,
      passwordController.text,
    );

    _loading = false;
    if (!ok) _error = 'Credenciales incorrectas';
    // shell.initialize();
    if(ok)
    {
      usernameController.text = '';
      passwordController.text = '';
    }
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
