// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryRepository _repo;
  List<Category> _allItems = [];


  CategoryProvider(this._repo);

  // Llama esto en initState de tu pantalla o nada más instanciar el provider
  Future<void> loadAll() async {
    _allItems = await _repo.getAllCategories();
    // _carta = await _repo.getCarta();

    notifyListeners();
  }

  List<Category> get allItems => _allItems;

  // List<Category> get carta => _carta;

  Future<Category?> getCategory(String id) async {
    final category = await _repo.getCategory(id);
    notifyListeners();
    return category;
  }
}
