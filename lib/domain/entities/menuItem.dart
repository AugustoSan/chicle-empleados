import '../enums/enums.dart';

class MenuItem {
  final int?      id;          // Nullable porque la BD lo asigna
  final String   name;
  final String?  description;  // Opcional
  final double   price;
  final EnumMenuItemCategory   category;     // p.e. 'bebida', 'platillo', 'postre'
  final String?  imageUrl;     // Si quieres mostrar foto

  MenuItem({
    this.id,
    required this.name,
    this.description,
    required this.price,
    required this.category,
    this.imageUrl,
  });
}