import 'package:chicle_app_empleados/models/models.dart';
import 'package:uuid/uuid.dart';

import '../enums/enums.dart';

class Product {
  late String   id;
  late String   name;
  late double   price;
  late EnumProductCategory   category;     // p.e. 'bebida', 'platillo', 'postre'
  late String?  description;  // Opcional
  late String?  imageUrl;     // Si quieres mostrar foto

  Product(
    this.id,
    this.name,
    this.description,
    this.price,
    this.category,
    this.imageUrl,
  );

  Product.withoutId({
    required this.name,
    this.description,
    required this.price,
    required this.category,
    this.imageUrl,
  }){
    this.id = const Uuid().v4();
  }

  Product.withAll({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.category,
    this.imageUrl,
  });

  Product.empty(){
    id = const Uuid().v4();
    name = 'sin nombre';
    description = null;
    price = 0.0;
    category = EnumProductCategory.bebida;
    imageUrl = null;
  }

  Product.fromModel(ProductModel model) {
    id = model.id;
    name = model.name;
    price = model.price;
    category = EnumProductCategory.values[model.category];
    description = model.description;
    imageUrl = model.imageUrl;
  }

  ProductModel parseToModel() => ProductModel(
    id: id,
    name: name,
    price: price,
    category: category.index,
    description: description,
    imageUrl: imageUrl,
  );
}