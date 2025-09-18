import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';
import '../utils/utils.dart';

class ProfileController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  int id = -1;
  // final nameC = TextEditingController();
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  final passwordNewC = TextEditingController();
  final passwordConfirmC = TextEditingController();
  late String currentName;
  late String currentPassword;
  final ValueNotifier<String?> imageProfile = ValueNotifier<String?>(null);

  bool  _loading = false;
  String? _error;
  bool  get loading => _loading;
  String? get error => _error;

  
  final UserProvider _userProvider;
  final AuthProvider _authProvider;

  ProfileController(this._userProvider, this._authProvider);

  Future<void> loadFromUser() async {
    final user = await _userProvider.getCurrentUser();
    if (user == null) return;
    id = user.id;
    // nameC.text     = user.name;
    usernameC.text = _authProvider.username;
    passwordC.text = '';
    passwordNewC.text = '';
    passwordConfirmC.text = '';
    imageProfile.value = user.imageUrl;
    currentName = user.name;
    notifyListeners();
  }

  Future<void> clean() async {
    passwordC.text = '';
    passwordNewC.text = '';
    passwordConfirmC.text = '';
  }

  Future<String> save(BuildContext context) async {
    if (!formKey.currentState!.validate()) return 'Formulario inválido';
    _loading = true;
    _error   = null;
    notifyListeners();

    if(_authProvider.username != usernameC.text) {
      final ok = await _authProvider.changeUsername(newUsername: usernameC.text);
      if (!ok) _error = 'Ocurrio un error al guardar';
    }

    if(passwordC.text.isNotEmpty) {
      final validPassword = await _authProvider.validatePassword(usernameC.text, passwordC.text);
      if (!validPassword) {
        _error = 'La contraseña actual no es correcta';
        return _error!;
      }
      if(passwordNewC.text.isNotEmpty) {
        if(passwordConfirmC.text.isEmpty) {
          _error = 'La confirmación de la contraseña es requerida';
          return _error!;
        }
        if(passwordConfirmC.text.isNotEmpty && passwordConfirmC.text != passwordNewC.text) {
          _error = 'Las contraseñas no coinciden';
          return _error!;
        }
        final result = await _authProvider.changePassword(
          currentPassword: passwordC.text,
          newPassword: passwordNewC.text
        );
        if (!result) _error = 'Ocurrio un error al guardar la contraseña';
        clean();
      }
    }

    notifyListeners();
    return _error ?? '';
  }

  Future<void> saveImage() async {
    final imageUrl = await Picture().saveImage(PictureType.profile);

    if(imageUrl != null){
      imageProfile.value = imageUrl;
    }
    notifyListeners();
  }

  

  @override
  void dispose() {
    // nameC.dispose();
    usernameC.dispose();
    passwordC.dispose();
    imageProfile.dispose();
    passwordNewC.dispose();
    passwordConfirmC.dispose();
    super.dispose();
  }
}
