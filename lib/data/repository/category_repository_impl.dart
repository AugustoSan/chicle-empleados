import 'dart:convert'; // Para json.decode
import 'package:chicle_app_empleados/data/services/image_service.dart';
import 'package:http/http.dart' as http; // Para http requests
import 'package:chicle_app_empleados/models/models.dart';
import 'package:chicle_app_empleados/data/datasource/hive_data_source.dart';
// import 'package:hive/hive.dart';

import '../../domain/domain.dart';

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
  Future<RestaurantMenu?> _fetchAndCacheMenu() async {
    final client = http.Client();
    try {
      final response = await client.get(Uri.parse(apiUrl + 'assets/data/menu.json')).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        final restaurant = RestaurantMenu.fromJson(jsonResponse);

        return restaurant;
      } else {
        print('Failed to load menu. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  @override
  Future<List<Category>> loadCategories() async {
    final restaurant = await _fetchAndCacheMenu();

    if(restaurant == null) return [];

    // 
    for (var category in restaurant.categories) {
      await _saveOrUpdate(category);
    }

    return restaurant.categories;

  }

  @override
  Future<List<Category>> getAllCategories() async {
    List<Category> localCategorys = await _getAllCategorysFromHive();

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

  Future<bool> _saveOrUpdate(Category category) async {
    final box = await _hiveDataSource.openBox<CategoryModel>(_CATEGORY_BOX);

    for (var product in category.items) {
      if (product.imageUrl != null && product.imageUrl!.isNotEmpty) {
        String fileName = product.imageUrl!.split('/').last;
        final imageService = ImageService();
        final imagePath = await imageService.saveImageFromURL(product.imageUrl!, fileName);
        product.imageUrl = imagePath;
      }
    }

    final model = category.parseToModel();
    
    await box.put(category.id, model);
    return true;
  }

}
