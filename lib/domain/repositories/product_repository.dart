import '../domain.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  // Future<List<Category>> getCarta();
  Future<Product?> getProduct(String id);
  // Future<bool> saveProduct(Product product);
  // Future<bool> updateProduct(String id, Product product);
  // Future<bool> deleteProduct(String id);
}