// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class MenuItemProvider with ChangeNotifier {
  final MenuItemRepository _repo;
  List<MenuItem> _allItems = [];

  MenuItemProvider(this._repo);

  // Llama esto en initState de tu pantalla o nada más instanciar el provider
  Future<void> loadAll() async {
    _allItems = await _repo.getMenuItems();
    notifyListeners();
  }

  // Exposiciones filtradas, ya sin Future
  List<MenuItem> get bebidas =>
    _allItems.where((i) => i.category == EnumMenuItemCategory.bebida).toList();

  List<MenuItem> get alimentos =>
    _allItems.where((i) => i.category == EnumMenuItemCategory.alimento).toList();

  List<MenuItem> get menus =>
    _allItems.where((i) => i.category == EnumMenuItemCategory.menu).toList();

  List<MenuItem> get extras =>
    _allItems.where((i) => i.category == EnumMenuItemCategory.extra).toList();

  Future<MenuItem?> getMenuItem(int id) async {
    final menuItem = await _repo.getMenuItem(id);
    notifyListeners();
    return menuItem;
  }

  Future<int> saveMenuItem(MenuItem menuItem) async {
    final res = await _repo.saveMenuItem(menuItem);
    loadAll();
    return res;
  }

  Future<int> updateMenuItem(int id, MenuItem menuItem) async {
    final res = await _repo.updateMenuItem(id, menuItem);
    loadAll();
    return res;
  }

  Future<int> deleteMenuItem(int id) async {
    final res = await _repo.deleteMenuItem(id);
    loadAll();
    return res;
  }
}
