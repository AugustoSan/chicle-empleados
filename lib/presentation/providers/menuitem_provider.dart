// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class MenuItemProvider with ChangeNotifier {
  final MenuItemRepository _repo;

  MenuItemProvider(this._repo);
  
  Future<List<MenuItem>> getMenuItems() async {
    final menuItems = await _repo.getMenuItems();
    notifyListeners();
    return menuItems;
  }

  Future<MenuItem?> getMenuItem(int id) async {
    final menuItem = await _repo.getMenuItem(id);
    notifyListeners();
    return menuItem;
  }

  Future<int> saveMenuItem(MenuItem menuItem) async {
    final res = await _repo.saveMenuItem(menuItem);
    notifyListeners();
    return res;
  }

  Future<int> updateMenuItem(MenuItem menuItem) async {
    final res = await _repo.updateMenuItem(menuItem);
    notifyListeners();
    return res;
  }

  Future<int> deleteMenuItem(int id) async {
    final res = await _repo.deleteMenuItem(id);
    notifyListeners();
    return res;
  }
}
