import '../domain.dart';

abstract class CategoryRepository {
  Future<List<Category>> loadCategories();
  Future<List<Category>> getAllCategories();
  Future<Category?> getCategory(String id);
}