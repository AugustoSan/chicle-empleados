import '../enums/enums.dart';

class MenuItem {
  late int?      id;          // Nullable porque la BD lo asigna
  late String   name;
  late String?  description;  // Opcional
  late double   price;
  late EnumMenuItemCategory   category;     // p.e. 'bebida', 'platillo', 'postre'
  late String?  imageUrl;     // Si quieres mostrar foto

  MenuItem(
    this.id,
    this.name,
    this.description,
    this.price,
    this.category,
    this.imageUrl,
  );

  MenuItem.withoutId({
    required this.name,
    this.description,
    required this.price,
    required this.category,
    this.imageUrl,
  }){
    id = null;
  }

  MenuItem.withAll({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.category,
    this.imageUrl,
  });

  MenuItem.empty(){
    id = -1;
    name = 'sin nombre';
    description = null;
    price = 0.0;
    category = EnumMenuItemCategory.bebida;
    imageUrl = null;
  }
}