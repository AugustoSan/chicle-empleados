import 'dart:convert'; // Para json.decode
import 'package:http/http.dart' as http; // Para http requests
import 'package:chicle_app_empleados/models/models.dart';
import 'package:chicle_app_empleados/data/datasource/hive_data_source.dart';
// import 'package:hive/hive.dart';

import '../../domain/domain.dart';

final String apiUrl = 'https://augustosan.github.io/chicle-empleados/assets/data/menu.json';

class ProductRepositoryImpl extends ProductRepository {
  static const _PRODUCT_BOX = Boxes.productsBox;
  final HiveDataSource _hiveDataSource;

  ProductRepositoryImpl(this._hiveDataSource);

  /// Fetches all products directly from the local Hive box.
  Future<List<Product>> _getAllProductsFromHive() async {
    final box = await _hiveDataSource.openBox<ProductModel>(_PRODUCT_BOX);
    if (box.isEmpty) {
      return [];
    }
    return box.values.map((model) => Product.fromModel(model)).toList();
  }

  /// Fetches the menu from the network, parses it, and caches any new products into Hive.
  Future<RestaurantMenu> _fetchAndCacheMenu() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      final restaurant = RestaurantMenu.fromJson(jsonResponse);

      // Check each product and save it to Hive if it doesn't exist.
      for (var section in restaurant.categories) {
        for (var item in section.items) {
          final exists = await getProduct(item.id);
          if (exists == null) {
            // Product is not in the local DB, so we save it.
            await _save(item);
          }
        }
      }
      return restaurant;
    } else {
      throw Exception('Failed to load menu. Status Code: ${response.statusCode}');
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    // 1. Try to load from Hive first.
    List<Product> localProducts = await _getAllProductsFromHive();

    // 2. If Hive is empty, fetch from network and cache.
    if (localProducts.isEmpty) {
      final restaurant = await _fetchAndCacheMenu();
      List<Product> allProducts = [];
      for (var category in restaurant.categories) {
        allProducts.addAll(category.items);
      }
      return allProducts;
    }

    // 3. Return local data.
    return localProducts;
  }

  @override
  Future<List<Category>> getCarta() async {
    // 1. Try to load products from Hive.
    final products = await _getAllProductsFromHive();

    // 2. If Hive is empty, fetch from network.
    if (products.isEmpty) {
      final restaurant = await _fetchAndCacheMenu();
      return restaurant.categories;
    }

    // 3. If we have local products, group them by category.
    final Map<String, List<Product>> grouped = {};
    for (var product in products) {
      final categoryName = product.category.name; // Assuming EnumProductCategory has a name property
      (grouped[categoryName] ??= []).add(product);
    }

    // 4. Convert the grouped map into a List<Category>.
    return grouped.entries.map((entry) {
      return Category(name: entry.key, items: entry.value);
    }).toList();
  }

  @override
  Future<Product?> getProduct(String id) async {
    final box = await _hiveDataSource.openBox<ProductModel>(_PRODUCT_BOX);
    final productModel = box.get(id);
    if (productModel == null) return null;
    return Product.fromModel(productModel);
  }

  @override
  Future<bool> saveProduct(Product product) async {
    return await _save(product);
  }

  @override
  Future<bool> updateProduct(String id, Product product) async {
    final exist = await getProduct(id);
    if(exist == null) throw Exception('La orden con id $id no existe');

    return _update(id, Product.withAll(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      category: product.category,
      imageUrl: product.imageUrl,
    ));
  }

  @override
  Future<bool> deleteProduct(String id) async {
    final box =  await _hiveDataSource.openBox<ProductModel>(_PRODUCT_BOX);
    final exist = await getProduct(id);
    if(exist == null) throw Exception('La orden con id $id no existe');

    await box.delete(id);
    return true;
  }
  Future<void> close() async {
    // if (Hive.isBoxOpen(_PRODUCT_BOX)) {
    //   final box = Hive.box<OrderModel>(_PRODUCT_BOX);
    //   await box.close();
    // }
    await _hiveDataSource.close<ProductModel>(_PRODUCT_BOX);
  }
  Future<void> clearAllData() async {
    final orderBox = await _hiveDataSource.openBox<ProductModel>(_PRODUCT_BOX);
    await orderBox.clear();
  }

  Future<bool> _save(Product product) async {
    final box = await _hiveDataSource.openBox<ProductModel>(_PRODUCT_BOX);
    final exists = await getProduct(product.id);
    if (exists != null) return false;

    final model = product.parseToModel();
    
    await box.put(product.id, model);
    return true;
  }
  Future<bool> _update(String id, Product product) async {
    final box = await _hiveDataSource.openBox<ProductModel>(_PRODUCT_BOX);
    final exists = await getProduct(id);
    if (exists == null) return false;

    final model = product.parseToModel();
    
    await box.put(product.id, model);
    return true;
  }
}
