// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class SaleProvider with ChangeNotifier {
  final SalesRepository _repo;
  List<Sales> _items = [];

  SaleProvider(this._repo);

  // Llama esto en initState de tu pantalla o nada más instanciar el provider
  Future<void> loadAll() async {
    _items = await _repo.getSales();
    notifyListeners();
  }

  // Exposiciones filtradas, ya sin Future
  List<Sales> get pendientes =>
    _items.where((i) => i.status == EnumSalesStatus.pending).toList();

  List<Sales> get completados =>
    _items.where((i) => i.status == EnumSalesStatus.completed).toList();

  List<Sales> get cancelados =>
    _items.where((i) => i.status == EnumSalesStatus.cancelled).toList();
  
  List<Sales> get allSales =>
    _items;

  Future<Sales?> getSale(int id) async {
    final sale = await _repo.getSale(id);
    notifyListeners();
    return sale;
  }

  Future<int> saveSale(Sales sales) async {
    final res = await _repo.saveSale(sales);
    loadAll();
    return res;
  }

  Future<int> updateSale(int id, Sales sales) async {
    final res = await _repo.updateSale(id, sales);
    loadAll();
    return res;
  }

  Future<int> deleteSale(int id) async {
    final res = await _repo.deleteSale(id);
    loadAll();
    return res;
  }
}
