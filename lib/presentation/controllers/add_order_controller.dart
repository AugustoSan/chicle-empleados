import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class AddOrderController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  // final ValueNotifier<Customer?> customer = ValueNotifier<Customer?>(null);

  bool  _loading = false;
  String? _error;

  bool  get loading => _loading;
  String? get error => _error;

  final OrderRepository _orderRepository;
  final UserProvider _userProvider;


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
        customer: 'Público en general',
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

  @override
  void dispose() {
    super.dispose();
  }
}
