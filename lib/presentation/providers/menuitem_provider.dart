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

  Future<List<MenuItem>> getBebidas() async {
    final items = await _repo.getMenuItems();
    List<MenuItem> bebidas = [];
    for (final item in items) {
      if (item.category == EnumMenuItemCategory.bebida) {
        bebidas.add(item);
      }
    }
    notifyListeners();
    return bebidas;
  }

  Future<List<MenuItem>> getComida() async {
    final items = await _repo.getMenuItems();
    List<MenuItem> comida = [];
    for (final item in items) {
      if (item.category == EnumMenuItemCategory.comida) {
        comida.add(item);
      }
    }
    notifyListeners();
    return comida;
  }

  Future<List<MenuItem>> getMenus() async {
    final items = await _repo.getMenuItems();
    List<MenuItem> menus = [];
    for (final item in items) {
      if (item.category == EnumMenuItemCategory.menu) {
        menus.add(item);
      }
    }
    notifyListeners();
    return menus;
  }

  Future<List<MenuItem>> getExtras() async {
    final items = await _repo.getMenuItems();
    List<MenuItem> extras = [];
    for (final item in items) {
      if (item.category == EnumMenuItemCategory.extra) {
        extras.add(item);
      }
    }
    notifyListeners();
    return extras;
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
