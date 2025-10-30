import 'package:chicle_app_empleados/domain/domain.dart';

class ProductUtil {
  List<Product> getProductItems(List<Category> categories) {
    final List<Product> map = [];
    for (var item in categories) {
      for (var product in item.items) {
        if(product.available) map.add(product);
      }
    }
    return map;
  }
}