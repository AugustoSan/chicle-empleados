import 'package:chicle_app_empleados/domain/domain.dart';

// Clase que representa una sección del menú (ej. "Bebidas calientes")
class Category {
  final String name;
  final List<Product> items;

  Category({
    required this.name,
    required this.items,
  });

  // Factory constructor para crear una instancia de Category desde un mapa JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    // Mapeamos la lista de JSON de 'items' a una lista de objetos Product
    var itemsList = json['items'] as List;
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
}