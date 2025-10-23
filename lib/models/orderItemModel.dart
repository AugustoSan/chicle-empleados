// models/orderItemModel.dart
import 'package:chicle_app_empleados/models/models.dart'; // Importa tu ProductModel
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart'; // Para generar IDs únicos si OrderItem también los necesita

part 'orderItemModel.g.dart';

@HiveType(typeId: 4) // Asegúrate de que este typeId sea único y no esté en uso
class OrderItemModel extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String orderId;

  @HiveField(2)
  ProductModel product;

  @HiveField(3)
  int quantity;

  @HiveField(4)
  double priceAtOrder; // Almacena el precio del producto en el momento de la orden

  @HiveField(5)
  String? specialIndications; // Indicaciones especiales, puede ser null

  OrderItemModel({
    String? id,
    required this.orderId,
    required this.product,
    required this.quantity,
    required this.priceAtOrder,
    this.specialIndications, // Opcional
  }) : this.id = id ?? const Uuid().v4(); // Genera ID si no se proporciona
}