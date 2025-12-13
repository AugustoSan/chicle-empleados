// presentation/providers/add_cash_cut_viewmodel.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/providers/cash_cut_provider.dart';

class AddCashCutViewModel extends ChangeNotifier {
  // Repositorios/Providers
  final OrderRepository _orderRepository;
  final UserRepository _userRepository;
  final CashCutProvider _cashCutProvider;
  
  // Estado
  List<User> _users = [];
  List<Order> _orders = [];
  User? _selectedUser;
  bool _loading = false;
  String? _error;
  
  // Controladores (podrían estar aquí o en el widget)
  final TextEditingController countedCashInitC = TextEditingController();
  final TextEditingController countedCashC = TextEditingController();
  final TextEditingController cardPaymentsC = TextEditingController();
  final TextEditingController expensesC = TextEditingController();
  final TextEditingController notesC = TextEditingController();

  // Getters
  List<User> get users => _users;
  List<Order> get orders => _orders;
  User? get selectedUser => _selectedUser;
  bool get loading => _loading;
  String? get error => _error;
  
  double get initialCash => double.tryParse(countedCashInitC.text) ?? 0.0;
  
  // Cálculos computados
  double get cashSales => _calculateCashSales();
  double get cardSales => _calculateCardSales();
  double get otherPaymentSales => _calculateOtherSales();
  double get totalSales => cashSales + cardSales + otherPaymentSales;
  double get countedCash => double.tryParse(countedCashC.text) ?? 0.0;
  double get cardPayments => double.tryParse(cardPaymentsC.text) ?? 0.0;
  double get expenses => double.tryParse(expensesC.text) ?? 0.0;
  double get expectedCashInDrawer => initialCash + cashSales - expenses;
  double get difference => countedCash - expectedCashInDrawer;
  
  // Constructor
  AddCashCutViewModel({
    required OrderRepository orderRepository,
    required UserRepository userRepository,
    required CashCutProvider cashCutProvider,
  }) : _orderRepository = orderRepository,
       _userRepository = userRepository,
      _cashCutProvider = cashCutProvider {

        cardPaymentsC.text = '0';
        expensesC.text = '0';
        
        countedCashInitC.addListener(_notifyListeners);
        countedCashC.addListener(_notifyListeners);
        cardPaymentsC.addListener(_notifyListeners);
        expensesC.addListener(_notifyListeners);
  }

  // Método para notificar cambios
  void _notifyListeners() {
    notifyListeners();
  }
  
  // Métodos privados
  double _calculateCashSales() {
    return _orders
        .where((order) => 
            order.status == EnumOrderStatus.completed && 
            order.typePayment == EnumTypePayment.efectivo)
        .fold(0.0, (sum, order) => sum + order.total);
  }
  
  double _calculateCardSales() {
    return _orders
        .where((order) => 
            order.status == EnumOrderStatus.completed && 
            order.typePayment == EnumTypePayment.tarjeta)
        .fold(0.0, (sum, order) => sum + order.total);
  }
  
  double _calculateOtherSales() {
    return _orders
        .where((order) => 
            order.status == EnumOrderStatus.completed && 
            order.typePayment != EnumTypePayment.efectivo &&
            order.typePayment != EnumTypePayment.tarjeta)
        .fold(0.0, (sum, order) => sum + order.total);
  }
  
  // Métodos públicos
  Future<void> loadUsers() async {
    _setLoading(true);
    
    try {
      _users = await _userRepository.getAllUsers();
      
      if (_users.isNotEmpty) {
        await selectUser(_users.first);
      }
      
      _error = null;
    } catch (e) {
      _error = 'Error al cargar usuarios: $e';
    } finally {
      _setLoading(false);
    }
  }
  
  Future<void> selectUser(User user) async {
    _selectedUser = user;
    notifyListeners();
    
    await _loadOrdersForUser(user.id);
  }
  
  Future<void> _loadOrdersForUser(String userId) async {
    _setLoading(true);
    
    try {
      _orders = await _orderRepository.getOrdersByUser(userId);
      _orders = _orders.where((order) => 
        order.status == EnumOrderStatus.completed && !order.statusCashCut).toList();
      _error = null;
    } catch (e) {
      _error = 'Error al cargar órdenes: $e';
    } finally {
      _setLoading(false);
    }
  }
  
  Future<void> saveCashCut() async {
    // Validaciones
    if (selectedUser == null) {
      _error = 'Selecciona un usuario';
      notifyListeners();
      return;
    }
    
    if (countedCashC.text.isEmpty) {
      _error = 'Ingresa el efectivo contado';
      notifyListeners();
      return;
    }
    
    _setLoading(true);
    
    try {
      // Crear objeto CashCut
      final newCashCut = CashCut(
        date: DateTime.now(),
        userId: selectedUser!.id,
        initialCash: initialCash,
        cashSales: cashSales,
        cardSales: cardSales,
        otherPaymentSales: otherPaymentSales,
        countedCash: countedCash,
        expenses: expenses,
        notes: notesC.text,
      );
  
      await _cashCutProvider.saveCashCut(newCashCut);
  
      // Marcar las órdenes como incluidas en el corte
      for (var order in _orders) {
        order.statusCashCut = true;
        await _orderRepository.updateOrder(order.id, order);
      }
      
      // Éxito
      _error = null;
      
      // Limpiar formulario
      _resetForm();
      
    } catch (e) {
      _error = 'Error al guardar corte: $e';
    } finally {
      _setLoading(false);
    }
  }
  
  void _resetForm() {
    countedCashC.clear();
    cardPaymentsC.clear();
    expensesC.clear();
    notesC.clear();
    notifyListeners();
  }
  
  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  
  @override
  void dispose() {
    // Remover listeners
    countedCashInitC.removeListener(_notifyListeners);
    countedCashC.removeListener(_notifyListeners);
    cardPaymentsC.removeListener(_notifyListeners);
    expensesC.removeListener(_notifyListeners);
    
    countedCashInitC.dispose();
    countedCashC.dispose();
    cardPaymentsC.dispose();
    expensesC.dispose();
    notesC.dispose();
    
    super.dispose();
  }
}