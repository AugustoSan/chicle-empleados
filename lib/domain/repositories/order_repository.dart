import '../domain.dart';

abstract class OrderRepository {
  Future<List<Order>> getAllOrders();
  Future<List<Order>> getOrdersByUser(String userId);
  Future<Order?> getOrder(String id);
  Future<bool> saveOrder(Order order);
  Future<bool> updateOrder(String id, Order order);
  Future<bool> deleteOrder(String id);
}