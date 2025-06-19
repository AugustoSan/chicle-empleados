import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';
import '../utils/utils.dart';

class UpdateMenuItemController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  
  final nameC = TextEditingController();
  final descriptionC = TextEditingController();
  final priceC = TextEditingController();
  final ValueNotifier<EnumMenuItemCategory> type = ValueNotifier<EnumMenuItemCategory>(EnumMenuItemCategory.bebida);
  final ValueNotifier<String?> image = ValueNotifier<String?>(null);
  late int id;

  bool  _loading = false;
  String? _error;
  bool  get loading => _loading;
  String? get error => _error;

  final MenuItemProvider _menuItemProvider;

  UpdateMenuItemController(this._menuItemProvider, MenuItem menuItem){
    id = menuItem.id!;
    nameC.text = menuItem.name;
    descriptionC.text = menuItem.description ?? '';
    priceC.text = menuItem.price.toString();
    type.value = menuItem.category;
    image.value = menuItem.imageUrl;
  }

  Future<void> save(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    _loading = true;
    _error   = null;
    notifyListeners();

    await _menuItemProvider.updateMenuItem( id,
      MenuItem.withAll(
        id:           id,
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

  Future<void> delete(int id) async {
    _loading = true;
    _error   = null;
    notifyListeners();

    final ok = await _menuItemProvider.deleteMenuItem(id);

    _loading = false;
    if (ok == -1) _error = 'Ocurrio un error al eliminar';
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
