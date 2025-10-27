import 'package:chicle_app_empleados/domain/domain.dart';

class LoadCategoryUseCase {
  final CategoryRepository repo;
  LoadCategoryUseCase(this.repo);
  Future<List<Category>> call() => repo.loadCategories();
}

class GetCategoryUseCase {
  final CategoryRepository repo;
  GetCategoryUseCase(this.repo);
  Future<Category?> call(String id) => repo.getCategory(id);
}

class GetAllCategoriesUseCase {
  final CategoryRepository repo;
  GetAllCategoriesUseCase(this.repo);
  Future<List<Category>> call() => repo.getAllCategories();
}
