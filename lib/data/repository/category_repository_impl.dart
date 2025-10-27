import 'dart:convert'; // Para json.decode
import 'package:http/http.dart' as http; // Para http requests
import 'package:chicle_app_empleados/models/models.dart';
import 'package:chicle_app_empleados/data/datasource/hive_data_source.dart';
// import 'package:hive/hive.dart';

import '../../domain/domain.dart';

// final String apiUrl = 'https://augustosan.github.io/chicle-empleados/assets/data/menu.json';

class CategoryRepositoryImpl extends CategoryRepository {
  static const _CATEGORY_BOX = Boxes.categoryBox;
  final HiveDataSource _hiveDataSource;

  CategoryRepositoryImpl(this._hiveDataSource);

  /// Fetches all products directly from the local Hive box.
  Future<List<Category>> _getAllCategorysFromHive() async {
    final box = await _hiveDataSource.openBox<CategoryModel>(_CATEGORY_BOX);
    if (box.isEmpty) {
      return [];
    }
    return box.values.map((model) => Category.fromModel(model)).toList();
  }

  /// Fetches the menu from the network, parses it, and caches any new products into Hive.
  Future<RestaurantMenu> _fetchAndCacheMenu() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      final restaurant = RestaurantMenu.fromJson(jsonResponse);

      // Check each product and save it to Hive if it doesn't exist.
      for (var category in restaurant.categories) {
        await _save(category);
        // for (var item in category.items) {
        //   final exists = await getCategory(item.id);
        //   if (exists == null) {
        //     // Category is not in the local DB, so we save it.
        //     await _save(item);
        //   }
        // }
      }
      return restaurant;
    } else {
      throw Exception('Failed to load menu. Status Code: ${response.statusCode}');
    }
  }

  @override
  Future<List<Category>> loadCategories() async {
    List<Category> localCategorys = await _getAllCategorysFromHive();

    if (localCategorys.isEmpty) {
      final restaurant = await _fetchAndCacheMenu();
      
      return restaurant.categories;
    }

    // 3. Return local data.
    return localCategorys;
  }

  @override
  Future<List<Category>> getAllCategories() async {
    // 1. Try to load from Hive first.
    List<Category> localCategorys = await _getAllCategorysFromHive();

    // 2. If Hive is empty, fetch from network and cache.
    if (localCategorys.isEmpty) {
      final restaurant = await _fetchAndCacheMenu();
      // List<Category> allCategorys = restaurant.categories;
      // for (var category in restaurant.categories) {
      //   allCategorys.addAll(category);
      // }
      return restaurant.categories;
    }

    // 3. Return local data.
    return localCategorys;
  }

  // @override
  // Future<List<Category>> get() async {
  //   // 1. Try to load products from Hive.
  //   final products = await _getAllCategorysFromHive();

  //   // 2. If Hive is empty, fetch from network.
  //   if (products.isEmpty) {
  //     final restaurant = await _fetchAndCacheMenu();
  //     return restaurant.categories;
  //   }

  //   // 3. If we have local products, group them by category.
  //   final Map<String, List<Category>> grouped = {};
  //   for (var product in products) {
      
  //   }
  //   for (var product in products) {
  //     final categoryName = product.category.name; // Assuming EnumCategoryCategory has a name property
  //     (grouped[categoryName] ??= []).add(product);
  //   }

  //   // 4. Convert the grouped map into a List<Category>.
  //   return grouped.entries.map((entry) {
  //     return Category(name: entry.key, items: entry.value);
  //   }).toList();
  // }

  @override
  Future<Category?> getCategory(String id) async {
    final box = await _hiveDataSource.openBox<CategoryModel>(_CATEGORY_BOX);
    final productModel = box.get(id);
    if (productModel == null) return null;
    return Category.fromModel(productModel);
  }

  // @override
  // Future<bool> saveCategory(Category product) async {
  //   return await _save(product);
  // }

  // @override
  // Future<bool> updateCategory(String id, Category product) async {
  //   final exist = await getCategory(id);
  //   if(exist == null) throw Exception('La orden con id $id no existe');

  //   return _update(id, Category.withAll(
  //     id: id,
  //     name: product.name,
  //     description: product.description,
  //     price: product.price,
  //     category: product.category,
  //     imageUrl: product.imageUrl,
  //   ));
  // }

  // @override
  // Future<bool> deleteCategory(String id) async {
  //   final box =  await _hiveDataSource.openBox<CategoryModel>(_CATEGORY_BOX);
  //   final exist = await getCategory(id);
  //   if(exist == null) throw Exception('La orden con id $id no existe');

  //   await box.delete(id);
  //   return true;
  // }
  Future<void> close() async {
    // if (Hive.isBoxOpen(_CATEGORY_BOX)) {
    //   final box = Hive.box<OrderModel>(_CATEGORY_BOX);
    //   await box.close();
    // }
    await _hiveDataSource.close<CategoryModel>(_CATEGORY_BOX);
  }
  Future<void> clearAllData() async {
    final orderBox = await _hiveDataSource.openBox<CategoryModel>(_CATEGORY_BOX);
    await orderBox.clear();
  }

  Future<bool> _save(Category product) async {
    final box = await _hiveDataSource.openBox<CategoryModel>(_CATEGORY_BOX);
    final exists = await getCategory(product.id);
    if (exists != null) return false;

    final model = product.parseToModel();
    
    await box.put(product.id, model);
    return true;
  }
  // Future<bool> _update(String id, Category product) async {
  //   final box = await _hiveDataSource.openBox<CategoryModel>(_CATEGORY_BOX);
  //   final exists = await getCategory(id);
  //   if (exists == null) return false;

  //   final model = product.parseToModel();
    
  //   await box.put(product.id, model);
  //   return true;
  // }
}
