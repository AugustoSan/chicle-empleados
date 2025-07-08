import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';
import '../utils/utils.dart';

class AddOrderController extends ChangeNotifier {
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

  AddOrderController(this._menuItemProvider);

  Future<void> save(BuildContext context) async {
    
    final error = validate();
    if (error != '') {
      _error = error;
      return;
    }
    _loading = true;
    _error   = null;
    notifyListeners();

    await _menuItemProvider.saveMenuItem(
      MenuItem.withoutId(
        name:         nameC.text,
        description:  descriptionC.text,
        price:        double.parse(priceC.text),
        category:     type.value,
        imageUrl:     image.value ?? '',
      )
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Guardado ✔️')),
    );
    Navigator.pop(context);

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

  String validate() {
    if(nameC.text.isEmpty) return 'Nombre inválido';
    if(priceC.text.isEmpty) return 'Precio inválido';
    return '';
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
