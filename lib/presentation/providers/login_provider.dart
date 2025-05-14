import 'package:flutter/material.dart';
import '../../presentation/providers/auth_provider.dart';

class LoginViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool  _loading = false;
  String? _error;
  bool  get loading => _loading;
  String? get error => _error;

  final AuthProvider _auth;

  LoginViewModel(this._auth);

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
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
