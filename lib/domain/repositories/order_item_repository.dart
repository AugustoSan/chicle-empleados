import 'package:chicle_app_empleados/domain/domain.dart';

abstract class OrderItemRepository {
  Future<List<OrderItem>> getItemsByOrder(String idOrder);
  Future<OrderItem?> getOrderItem(String id);
}