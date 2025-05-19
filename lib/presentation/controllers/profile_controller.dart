import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

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

  Future<void> save(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
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
  }

  Future<void> saveImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      imageProfile.value = image.path;
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
