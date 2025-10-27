import 'package:chicle_app_empleados/models/models.dart';
import 'package:uuid/uuid.dart';

class Product {
  late String   id;
  late String   name;
  late double   price;
  late String?  description;  // Opcional
  late String?  imageUrl;     // Si quieres mostrar foto

  Product(
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
  );

  Product.withoutId({
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
  }){
    this.id = const Uuid().v4();
  }

  Product.withAll({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
  });

  Product.empty(){
    id = const Uuid().v4();
    name = 'sin nombre';
    description = null;
    price = 0.0;
    imageUrl = null;
  }

  Product.fromModel(ProductModel model) {
    id = model.id;
    name = model.name;
    price = model.price;
    description = model.description;
    imageUrl = model.imageUrl;
  }

  // Factory constructor para crear una instancia de MenuItem desde un mapa JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    final imageStrigUrl = json['imageUrl'];
    final imageUrl = imageStrigUrl.toString().replaceAll('./', 'https://augustosan.github.io/chicle-empleados/');
    return Product.withAll(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
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
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  ProductModel parseToModel() => ProductModel(
    id: id,
    name: name,
    price: price,
    description: description,
    imageUrl: imageUrl,
  );
}