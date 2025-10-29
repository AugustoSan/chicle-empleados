// lib/models/menu_model.dart

// Clase principal que representa todo el menú del restaurante
import 'package:chicle_app_empleados/domain/domain.dart';

class RestaurantMenu {
  final List<Category> categories;

  RestaurantMenu({
    required this.categories,
  });

  // Factory constructor para crear una instancia de RestaurantMenu desde un mapa JSON
  factory RestaurantMenu.fromJson(Map<String, dynamic> json) {
    // Mapeamos la lista de JSON de 'categories' a una lista de objetos Section
    var categoriesList = json['items'] as List;
    List<Category> parsedSections = categoriesList
        .map((sectionJson) => Category.fromJson(sectionJson))
        .toList();

    return RestaurantMenu(
      categories: parsedSections,
    );
  }

  // Opcional: Para convertir el objeto Dart de nuevo a un JSON (útil para POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'categories': categories.map((section) => section.toJson()).toList(),
    };
  }
}