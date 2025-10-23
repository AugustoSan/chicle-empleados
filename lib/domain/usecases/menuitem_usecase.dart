// import '../entities/product.dart';
// import '../../data/repository/menuitem_repository_impl.dart';

// class GetMenuItems {
//   final MenuItemRepositoryImpl repository;

//   GetMenuItems(this.repository);

//   Future<List<MenuItem>> call() {
//     return repository.getMenuItems();
//   }
// }

// class GetMenuItem {
//   final MenuItemRepositoryImpl repository;

//   GetMenuItem(this.repository);

//   Future<MenuItem?> call(int id) {
//     return repository.getMenuItem(id);
//   }
// }

// class AddMenuItem {
//   final MenuItemRepositoryImpl repository;

//   AddMenuItem(this.repository);

//   Future<void> call(MenuItem product) {
//     return repository.saveMenuItem(product);
//   }
// }

// class UpdateMenuItem {
//   final MenuItemRepositoryImpl repository;

//   UpdateMenuItem(this.repository);

//   Future<void> call(int id, MenuItem product) {
//     return repository.updateMenuItem(id, product);
//   }
// }

// class DeleteMenuItem {
//   final MenuItemRepositoryImpl repository;

//   DeleteMenuItem(this.repository);

//   Future<void> call(int id) {
//     return repository.deleteMenuItem(id);
//   }
// }
