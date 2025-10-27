// import 'package:flutter/material.dart';
// import '../../domain/domain.dart';
// import '../providers/providers.dart';
// import '../utils/utils.dart';

// class AddProductController extends ChangeNotifier {
//   final formKey = GlobalKey<FormState>();
//   final nameC = TextEditingController();
//   final descriptionC = TextEditingController();
//   final priceC = TextEditingController();
//   final ValueNotifier<EnumProductCategory> type = ValueNotifier<EnumProductCategory>(EnumProductCategory.bebida);
//   final ValueNotifier<String?> image = ValueNotifier<String?>(null);

//   bool  _loading = false;
//   String? _error;
//   bool  get loading => _loading;
//   String? get error => _error;

//   final ProductProvider _ProductProvider;

//   AddProductController(this._ProductProvider);

//   Future<String> save(BuildContext context) async {
    
//     final error = validate();
//     if (error != '') {
//       _error = error;
//       return error;
//     }
//     _loading = true;
//     _error   = null;
//     notifyListeners();

//     final ok = await _ProductProvider.saveProduct(
//       Product.withoutId(
//         name:         nameC.text,
//         description:  descriptionC.text,
//         price:        double.parse(priceC.text),
//         category:     type.value,
//         imageUrl:     image.value ?? '',
//       )
//     );
//     if (ok == -1) {
//       _error = 'Ocurrio un error al guardar';
//       return error;
//     }
//     _loading = false;
//     notifyListeners();
//     return error;
//   }

//   Future<void> saveImage() async {
//     final imageUrl = await Picture().saveImage(PictureType.data);

//     if(imageUrl != null){
//       image.value = imageUrl;
//     }
//     notifyListeners();
//   }

//   String validate() {
//     if(nameC.text.isEmpty) return 'Nombre inválido';
//     if(priceC.text.isEmpty) return 'Precio inválido';
//     return '';
//   }

//   @override
//   void dispose() {
//     nameC.dispose();
//     descriptionC.dispose();
//     priceC.dispose();
//     image.dispose();
//     type.dispose();
//     super.dispose();
//   }
// }
