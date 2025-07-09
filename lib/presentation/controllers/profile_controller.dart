import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';
import '../utils/utils.dart';

class ProfileController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  int id = -1;
  final nameC = TextEditingController();
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  final ValueNotifier<String?> imageProfile = ValueNotifier<String?>(null);

  bool  _loading = false;
  String? _error;
  bool  get loading => _loading;
  String? get error => _error;

  final UserProvider _userProvider;

  ProfileController(this._userProvider);

  Future<void> loadFromUser(String username) async {
    final user = await _userProvider.getUser(username);
    if (user == null) return;
    id = user.id;
    nameC.text     = user.name;
    usernameC.text = user.username;
    passwordC.text = user.passwordHash;
    imageProfile.value = user.imageUrl;
    notifyListeners();
  }

  Future<String> save(BuildContext context) async {
    if (!formKey.currentState!.validate()) return 'Formulario inválido';
    _loading = true;
    _error   = null;
    notifyListeners();

    final ok = await _userProvider.saveUser(
      User(
        id:           id,
        name:         nameC.text,
        username:     usernameC.text,
        passwordHash: passwordC.text,
        imageUrl:     imageProfile.value!,
      )
    );

    _loading = false;
    if (!ok) _error = 'Ocurrio un error al guardar';
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
    nameC.dispose();
    usernameC.dispose();
    passwordC.dispose();
    imageProfile.dispose();
    super.dispose();
  }
}
