import 'package:chicle_app_empleados/domain/entities/entities.dart';

class OrderUtil {
  Map<Product, OrderItem> getOrderItems(List<Product> products) {
    final Map<Product, OrderItem> map = {};
    for (var product in products) {
      map[product] = OrderItem.fromProduct(product);
    }
    return map;
  }
}