// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class OrderProvider with ChangeNotifier {
  final OrderRepository _repo;
  List<Order> _items = [];

  OrderProvider(this._repo);

  // Llama esto en initState de tu pantalla o nada más instanciar el provider
  Future<void> loadAll() async {
    _items = await _repo.getAllOrders();
    notifyListeners();
  }

  // Exposiciones filtradas, ya sin Future
  List<Order> get pendientes =>
    _items.where((i) => i.status == EnumOrderStatus.pending).toList();

  List<Order> get completados =>
    _items.where((i) => i.status == EnumOrderStatus.completed).toList();

  List<Order> get cancelados =>
    _items.where((i) => i.status == EnumOrderStatus.cancelled).toList();
  
  List<Order> get allOrders =>
    _items;

  Future<Order?> getOrder(String id) async {
    final sale = await _repo.getOrder(id);
    notifyListeners();
    return sale;
  }

  Future<bool> saveOrder(Order order) async {
    final res = await _repo.saveOrder(order);
    loadAll();
    return res;
  }

  Future<bool> updateOrder(String id, Order order) async {
    final res = await _repo.updateOrder(id, order);
    loadAll();
    return res;
  }

  Future<bool> cancelOrder(Order order) async {
    order.status = EnumOrderStatus.cancelled;
    final res = await _repo.updateOrder(order.id, order);
    loadAll();
    return res;
  }

  Future<bool> completeOrder(Order order) async {
    order.status = EnumOrderStatus.completed;
    final res = await _repo.updateOrder(order.id, order);
    loadAll();
    return res;
  }

  Future<bool> deleteOrder(String id) async {
    final res = await _repo.deleteOrder(id);
    loadAll();
    return res;
  }
}
