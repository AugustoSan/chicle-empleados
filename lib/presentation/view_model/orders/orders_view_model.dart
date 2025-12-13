// orders_viewmodel.dart
import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';

class OrdersViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;
  final AuthRepository _authRepository;
  List<Order> _orders = [];
  bool _isLoading = false;
  String? _error;
  bool _hasError = false;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _hasError;

  OrdersViewModel({required OrderRepository orderRepository, required AuthRepository authRepository})
      : _orderRepository = orderRepository,
        _authRepository = authRepository;

  Future<void> loadOrders() async {
    if (_isLoading) return;
    
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    
    try {
      final user = await _authRepository.getUserLogin();
      if (user == null) {
        _orders = [];
        _error = 'Usuario no autenticado';
        _hasError = true;
        return;
      }
      final userId = user.id;
      _orders = await _orderRepository.getOrdersByUser(userId);
      _error = null;
    } catch (e) {
      _hasError = true;
      _error = 'Error al cargar órdenes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadOrders();
  }
}