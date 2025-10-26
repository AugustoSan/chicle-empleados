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

  // Factory constructor para crear una instancia de MenuItem desde un mapa JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    final category = EnumProductCategory.values.firstWhere(
      (element) => element.name == json['category'],
      orElse: () => EnumProductCategory.extra,
    );
    final imageStrigUrl = json['imageUrl'];
    final imageUrl = imageStrigUrl.toString().replaceAll('./', 'https://augustosan.github.io/chicle-empleados/');
    return Product.withAll(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
      category: category,
      description: json['description'],
      imageUrl: imageUrl,
    );
  }

  // Opcional: Para convertir el objeto Dart de nuevo a un JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
    };
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