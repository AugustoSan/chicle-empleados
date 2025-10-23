import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class AddOrderController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  // final ValueNotifier<Customer?> customer = ValueNotifier<Customer?>(null);

  bool  _loading = false;
  String? _error;

  bool  get loading => _loading;
  String? get error => _error;


  final OrderRepository _orderRepository;
  final UserProvider _userProvider;
  // final CustomerProvider _customerProvider;

  AddOrderController(this._orderRepository, this._userProvider);
  
  Future<String> saveSale(BuildContext context, List<OrderItem> items) async {
    _loading = true;
    _error   = null;
    notifyListeners();

    final user = await _userProvider.getCurrentUser();
    if (user == null) {
      _error = 'Usuario no encontrado';
      return _error!;
    }

    final res = await _orderRepository.saveOrder(
      Order.withoutId(
        userId: user.id, 
        customer: nameC.text == '' ? 'Público en general' : nameC.text, 
        status: EnumOrderStatus.pending, 
        date: DateTime.now(), 
        items: items
      )
    );
    if(!res) {
      _error = 'Ocurrio un error al guardar';
      return _error!;
    }
    _loading = false;
    notifyListeners();
    return _error ?? '';
  }

  Future<String> addItems(BuildContext context, int saleId, List<OrderItem> items) async {
    
    return '';
  }

  Future<void> saveOrder(List<OrderItem> items) async {
    notifyListeners();
  }

  // Future<List<Customer>> searchCustomer(String filter) async {
  //   final customers = await _customerProvider.searchCustomer(filter);
  //   print('Customers: $customers');
  //   notifyListeners();
  //   return customers;
  // }

  @override
  void dispose() {
    nameC.dispose();
    super.dispose();
  }
}
