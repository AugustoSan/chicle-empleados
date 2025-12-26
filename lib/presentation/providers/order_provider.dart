// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class OrderProvider with ChangeNotifier {
  final OrderRepository _repo;
  final AuthRepository _authRepository;
  List<Order> _items = [];

  OrderProvider(this._repo, this._authRepository);

  // Llama esto en initState de tu pantalla o nada más instanciar el provider
  Future<void> loadAll() async {
    final user = await _authRepository.getUserLogin();
    if(user == null) return;
    _items = await _repo.getOrdersByUser( user.id );
    _items.sort((a, b) => b.date.compareTo(a.date));
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

  Future<List<Order>> getAllOrdersByUser(String userId) async {
    return await _repo.getOrdersByUser(userId);
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

  Future<bool> addCashCut(Order order) async {
    order.statusCashCut = true;
    final res = await _repo.updateOrder(order.id, order);
    loadAll();
    return res;
  }

  Future<bool> cancelOrder(Order order) async {
    order.status = EnumOrderStatus.cancelled;
    final res = await _repo.updateOrder(order.id, order);
    loadAll();
    return res;
  }

  Future<bool> completeOrder(Order order, EnumTypePayment typePayment) async {
    order.status = EnumOrderStatus.completed;
    order.typePayment = typePayment;
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
