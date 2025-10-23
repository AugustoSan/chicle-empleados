import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';
import '../utils/utils.dart';

class UpdateProductController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  
  final nameC = TextEditingController();
  final descriptionC = TextEditingController();
  final priceC = TextEditingController();
  final ValueNotifier<EnumProductCategory> type = ValueNotifier<EnumProductCategory>(EnumProductCategory.bebida);
  final ValueNotifier<String?> image = ValueNotifier<String?>(null);
  late String id;

  bool  _loading = false;
  String? _error;
  bool  get loading => _loading;
  String? get error => _error;

  final ProductProvider _productProvider;

  UpdateProductController(this._productProvider, Product product){
    id = product.id;
    nameC.text = product.name;
    descriptionC.text = product.description ?? '';
    priceC.text = product.price.toString();
    type.value = product.category;
    image.value = product.imageUrl;
  }

  Future<String> save(BuildContext context) async {
    if (!formKey.currentState!.validate()) return '';
    _loading = true;
    _error   = null;
    notifyListeners();

    final ok = await _productProvider.updateProduct( id,
      Product.withAll(
        id:           id,
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
    return _error ?? '';
  }

  Future<void> saveImage() async {
    final imageUrl = await Picture().saveImage(PictureType.data);

    if(imageUrl != null){
      image.value = imageUrl;
    }
    notifyListeners();
  }

  Future<void> delete(String id) async {
    _loading = true;
    _error   = null;
    notifyListeners();

    final ok = await _productProvider.deleteProduct(id);

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
