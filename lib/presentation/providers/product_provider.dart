// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository _repo;
  List<Product> _allItems = [];
  List<Category> _carta = [];


  ProductProvider(this._repo);

  // Llama esto en initState de tu pantalla o nada más instanciar el provider
  Future<void> loadAll() async {
    _allItems = await _repo.getAllProducts();
    _carta = await _repo.getCarta();

    notifyListeners();
  }

  // Exposiciones filtradas, ya sin Future
  List<Product> get bebidas =>
    _allItems.where((i) => i.category == EnumProductCategory.bebida).toList();

  List<Product> get alimentos =>
    _allItems.where((i) => i.category == EnumProductCategory.alimento).toList();

  List<Product> get menus =>
    _allItems.where((i) => i.category == EnumProductCategory.menu).toList();

  List<Product> get extras =>
    _allItems.where((i) => i.category == EnumProductCategory.extra).toList();

  List<Product> get allItems => _allItems;

  List<Category> get carta => _carta;

  Future<Product?> getProduct(String id) async {
    final product = await _repo.getProduct(id);
    notifyListeners();
    return product;
  }

  Future<bool> saveProduct(Product product) async {
    final res = await _repo.saveProduct(product);
    loadAll();
    return res;
  }

  Future<bool> updateProduct(String id, Product product) async {
    final res = await _repo.updateProduct(id, product);
    loadAll();
    return res;
  }

  Future<bool> deleteProduct(String id) async {
    final res = await _repo.deleteProduct(id);
    loadAll();
    return res;
  }
}
