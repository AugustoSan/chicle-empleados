import 'package:chicle_app_empleados/data/repository/repository.dart';
import 'package:chicle_app_empleados/domain/domain.dart';

class LoadCategoryUseCase {
  final CategoryRepositoryImpl repo;
  LoadCategoryUseCase(this.repo);
  Future<List<Category>> call() => repo.loadCategories();
}

class GetCategoryUseCase {
  final CategoryRepositoryImpl repo;
  GetCategoryUseCase(this.repo);
  Future<Category?> call(String id) => repo.getCategory(id);
}

class GetAllCategoriesUseCase {
  final CategoryRepositoryImpl repo;
  GetAllCategoriesUseCase(this.repo);
  Future<List<Category>> call() => repo.getAllCategories();
}
