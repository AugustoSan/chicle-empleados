import 'package:chicle_app_empleados/models/models.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'orderModel.g.dart';


@HiveType(typeId: 5)
class OrderModel extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String customer;

  @HiveField(4)
  double total;

  @HiveField(5)
  int status;

  @HiveField(6)
  bool statusCashCut;

  @HiveField(7)
  int? typePayment;

  @HiveField(8)
  List<OrderItemModel> items;

  OrderModel({
    String? id,
    DateTime? date,
    double? total,
    bool? statusCashCut,
    int? typePayment,
    required this.userId,
    required this.customer,
    required this.status,
    required this.items,
  }) : this.id = id ?? const Uuid().v4(),
       this.date = date ?? DateTime.now(),
       this.statusCashCut = statusCashCut ?? false,
       this.typePayment = typePayment,
       this.total = total ?? _calculateTotal(items);  // Asigna el ID proporcionado o genera uno nuevo

  static double _calculateTotal(List<OrderItemModel> items) {
    return items.fold(0.0, (sum, item) => sum + (item.quantity * item.priceAtOrder));
  }
}