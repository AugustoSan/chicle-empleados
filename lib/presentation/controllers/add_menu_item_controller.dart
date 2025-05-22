import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class AddMenuItemController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final descriptionC = TextEditingController();
  final priceC = TextEditingController();
  final ValueNotifier<EnumMenuItemCategory> type = ValueNotifier<EnumMenuItemCategory>(EnumMenuItemCategory.bebida);
  final ValueNotifier<String?> image = ValueNotifier<String?>(null);

  bool  _loading = false;
  String? _error;
  bool  get loading => _loading;
  String? get error => _error;

  final MenuItemProvider _menuItemProvider;

  AddMenuItemController(this._menuItemProvider);

  Future<void> save(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    _loading = true;
    _error   = null;
    notifyListeners();

    final ok = await _menuItemProvider.saveMenuItem(
      MenuItem(
        name:         nameC.text,
        description:  descriptionC.text,
        price:        double.parse(priceC.text),
        category:     type.value,
        imageUrl:     image.value ?? '',
      )
    );

    _loading = false;
    if (ok == -1) _error = 'Ocurrio un error al guardar';
    notifyListeners();
  }

  Future<void> saveImage() async {
    final picker = ImagePicker();
    final _image = await picker.pickImage(source: ImageSource.gallery);

    if(_image != null){
      image.value = _image.path;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    nameC.dispose();
    descriptionC.dispose();
    priceC.dispose();
    image.dispose();
    type.dispose();
    super.dispose();
  }
}
