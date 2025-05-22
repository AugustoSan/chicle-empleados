import '../entities/menuItem.dart';

abstract class MenuItemRepository {
  Future<List<MenuItem>> getMenuItems();
  Future<MenuItem?> getMenuItem(int id);
  Future<int> saveMenuItem(MenuItem menuItem);
  Future<int> updateMenuItem(MenuItem menuItem);
  Future<int> deleteMenuItem(int id);
}