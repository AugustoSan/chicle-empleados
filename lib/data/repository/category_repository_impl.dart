import 'dart:convert'; // Para json.decode
import 'package:chicle_app_empleados/data/services/image_service.dart';
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
    final response = await http.get(Uri.parse(apiUrl + 'assets/data/menu.json'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      final restaurant = RestaurantMenu.fromJson(jsonResponse);

      // Check each product and save it to Hive if it doesn't exist.
      for (var category in restaurant.categories) {
        await _save(category);
      }
      return restaurant;
    } else {
      throw Exception('Failed to load menu. Status Code: ${response.statusCode}');
    }
  }

  @override
  Future<void> loadCategories() async {
    List<Category> localCategorys = await _getAllCategorysFromHive();

    if (localCategorys.isEmpty) {
      await _fetchAndCacheMenu();
      // final restaurant = await _fetchAndCacheMenu();
      
      // return restaurant.categories;
    }

    // 3. Return local data.
    // return localCategorys;
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

  @override
  Future<Category?> getCategory(String id) async {
    final box = await _hiveDataSource.openBox<CategoryModel>(_CATEGORY_BOX);
    final categoryModel = box.get(id);
    if (categoryModel == null) return null;
    return Category.fromModel(categoryModel);
  }

  Future<void> close() async {
    await _hiveDataSource.close<CategoryModel>(_CATEGORY_BOX);
  }
  
  Future<void> clearAllData() async {
    final orderBox = await _hiveDataSource.openBox<CategoryModel>(_CATEGORY_BOX);
    await orderBox.clear();
  }

  Future<bool> _save(Category category) async {
    final box = await _hiveDataSource.openBox<CategoryModel>(_CATEGORY_BOX);
    final exists = await getCategory(category.id);
    if (exists != null) return false;

    for (var product in category.items) {
      if (product.imageUrl != null && product.imageUrl!.isNotEmpty) {
        String fileName = product.imageUrl!.split('/').last;
        final imageService = ImageService();
        final imagePath = await imageService.saveImageFromURL(apiUrl + product.imageUrl!, fileName);
        product.imageUrl = imagePath;
      }
    }

    final model = category.parseToModel();
    
    await box.put(category.id, model);
    return true;
  }

  // Future<bool> _update(String id, Category category) async {
  //   final box = await _hiveDataSource.openBox<CategoryModel>(_CATEGORY_BOX);
  //   final exists = await getCategory(id);
  //   if (exists == null) return false;

  //   final model = category.parseToModel();
    
  //   await box.put(category.id, model);
  //   return true;
  // }
}
