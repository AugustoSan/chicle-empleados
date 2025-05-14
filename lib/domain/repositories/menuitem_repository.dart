import '../entities/menuItem.dart';

abstract class MenuItemRepository {
  Future<List<MenuItem>> getMenuItems();
  Future<MenuItem?> getMenuItem(int id);
  Future<void> saveMenuItem(MenuItem menuItem);
  Future<void> updateMenuItem(MenuItem menuItem);
  Future<void> deleteMenuItem(int id);
}