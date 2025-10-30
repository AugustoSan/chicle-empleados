import 'package:chicle_app_empleados/domain/urls/urls.dart';
import 'package:chicle_app_empleados/models/models.dart';
import 'package:uuid/uuid.dart';

class Product {
  late String   id;
  late String   name;
  late double   price;
  late bool     available;
  // Propiedades opcionales
  late String?  description;  
  late String?  imageUrl;    

  Product(
    this.id,
    this.name,
    this.description,
    this.price,
    this.available,
    this.imageUrl,
  );

  Product.withoutId({
    required this.name,
    this.description,
    required this.price,
    required this.available,
    this.imageUrl,
  }){
    this.id = const Uuid().v4();
  }

  Product.withAll({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.available,
    this.imageUrl,
  });

  Product.empty(){
    id = const Uuid().v4();
    name = 'sin nombre';
    description = null;
    available = false;
    price = 0.0;
    imageUrl = null;
  }

  Product.fromModel(ProductModel model) {
    id = model.id;
    name = model.name;
    price = model.price;
    available = model.available;
    description = model.description;
    imageUrl = model.image;
  }

  // Factory constructor para crear una instancia de MenuItem desde un mapa JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    final imageStrigUrl = json['image'];
    final imageUrl = imageStrigUrl.toString().replaceAll('./', apiUrl);
    return Product.withAll(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      available: json['available'],
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
      'available': available,
      'description': description,
      'image': imageUrl,
    };
  }

  ProductModel parseToModel() => ProductModel(
    id: id,
    name: name,
    price: price,
    available: available,
    description: description,
    image: imageUrl,
  );
}