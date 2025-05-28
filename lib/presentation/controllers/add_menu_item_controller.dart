import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';
import '../utils/utils.dart';

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

    await _menuItemProvider.saveMenuItem(
      MenuItem(
        name:         nameC.text,
        description:  descriptionC.text,
        price:        double.parse(priceC.text),
        category:     type.value,
        imageUrl:     image.value ?? '',
      )
    );

    _loading = false;
    // if (ok == -1) _error = 'Ocurrio un error al guardar';
    notifyListeners();
  }

  Future<void> saveImage() async {
    final imageUrl = await Picture().saveImage(PictureType.data);

    if(imageUrl != null){
      image.value = imageUrl;
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
