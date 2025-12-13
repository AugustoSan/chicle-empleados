// import 'package:flutter/material.dart';
// import '../../domain/domain.dart';
// import '../providers/providers.dart';
 
// class AddCashCutController extends ChangeNotifier {
//   final formKey = GlobalKey<FormState>();
 
//   // Controllers para los campos de entrada del usuario
//   final countedCashC = TextEditingController();
//   final expensesC = TextEditingController();
//   final notesC = TextEditingController();
 
//   // Proveedores necesarios
//   final CashCutProvider _cashCutProvider;
//   final OrderProvider _orderProvider;
//   final AuthProvider _authProvider;
 
//   // Estado interno del controlador
//   bool  _loading = false;
//   String? _error;
//   bool  get loading => _loading;
//   String? get error => _error;
 
//   // Datos calculados y obtenidos
//   double _initialCash = 0.0;
//   double _cashSales = 0.0;
//   double _cardSales = 0.0;
//   double _otherPaymentSales = 0.0;
//   List<Order> _ordersForCut = [];
 
//   double get initialCash => _initialCash;
//   double get cashSales => _cashSales;
//   double get cardSales => _cardSales;
//   double get otherPaymentSales => _otherPaymentSales;
 
//   double get totalSales => _cashSales + _cardSales + _otherPaymentSales;
//   double get expectedCashInDrawer => _initialCash + _cashSales - (double.tryParse(expensesC.text) ?? 0.0);
 
//   AddCashCutController(this._cashCutProvider, this._orderProvider, this._authProvider);
 
//   /// Inicializa los datos necesarios para el corte de caja.
//   Future<void> initialize() async {
//     _loading = true;
//     notifyListeners();
 
//     // 1. Obtener el fondo de caja inicial del último corte
//     final lastCashCut = await _cashCutProvider.getLastCashCut();
//     _initialCash = lastCashCut?.countedCash ?? 0.0;
 
//     // 2. Calcular ventas desde el último corte
//     _calculateSalesFromOrders();
 
//     _loading = false;
//     notifyListeners();
//   }
 
//   /// Calcula las ventas a partir de las órdenes completadas y no cortadas.
//   void _calculateSalesFromOrders() {
//     final allOrders = _orderProvider.allOrders;
//     _ordersForCut = allOrders.where((order) =>
//         order.status == EnumOrderStatus.completed && !order.statusCashCut).toList();
 
//     // Reiniciar contadores
//     _cashSales = 0.0;
//     _cardSales = 0.0;
//     _otherPaymentSales = 0.0;
 
//     for (var order in _ordersForCut) {
//       // TODO: Asignar a la categoría de pago correcta cuando se agregue a la entidad Order.
//       // Por ahora, se asume que todo es en efectivo.
//       _cashSales += order.total;
//     }
//   }
 
//   /// Guarda el corte de caja.
//   Future<String> save(BuildContext context) async {
//     if (!formKey.currentState!.validate()) {
//       return 'Por favor, corrige los errores en el formulario.';
//     }
 
//     _loading = true;
//     _error   = null;
//     notifyListeners();
 
//     final userId = _authProvider.user?.id;
//     if (userId == null) {
//       _error = 'No se pudo identificar al usuario. Intenta iniciar sesión de nuevo.';
//       return _error!;
//     }
 
//     final newCashCut = CashCut(
//       date: DateTime.now(),
//       userId: userId,
//       initialCash: _initialCash,
//       cashSales: _cashSales,
//       cardSales: _cardSales,
//       otherPaymentSales: _otherPaymentSales,
//       countedCash: double.tryParse(countedCashC.text) ?? 0.0,
//       expenses: double.tryParse(expensesC.text) ?? 0.0,
//       notes: notesC.text,
//     );
 
//     await _cashCutProvider.saveCashCut(newCashCut);
 
//     // Marcar las órdenes como incluidas en el corte
//     for (var order in _ordersForCut) {
//       order.statusCashCut = true;
//       await _orderProvider.updateOrder(order.id, order);
//     }
 
//     _loading = false;
//     notifyListeners();
//     return ''; // Sin errores
//   }
 
//   @override
//   void dispose() {
//     countedCashC.dispose();
//     expensesC.dispose();
//     notesC.dispose();
//     super.dispose();
//   }
// }
