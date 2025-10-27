import '../domain.dart';

abstract class CategoryRepository {
  Future<void> loadCategories();
  Future<List<Category>> getAllCategories();
  Future<Category?> getCategory(String id);
}