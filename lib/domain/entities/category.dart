import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/models/models.dart';
import 'package:uuid/uuid.dart';

// Clase que representa una sección del menú (ej. "Bebidas calientes")
class Category {
  final String id;
  final String name;
  final List<Product> items;

  Category({
    String? id,
    required this.name,
    required this.items,
  }) : this.id = id ?? const Uuid().v4();

  // Factory constructor para crear una instancia de Category desde un mapa JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    // Extract the list of items from the JSON
    var itemsList = json['products'] as List;
    List<Product> parsedItems = itemsList
        .map((itemJson) => Product.fromJson(itemJson))
        .toList();

    return Category(
      name: json['name'],
      items: parsedItems,
    );
  }

  // Opcional: Para convertir el objeto Dart de nuevo a un JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  CategoryModel parseToModel() => CategoryModel(
    id: id,
    name: name,
    items: items.map((item) => item.parseToModel()).toList(),
  );

  Category.fromModel(CategoryModel model) :
    id = model.id,
    name = model.name,
    items = model.items.map((item) => Product.fromModel(item)).toList();
}