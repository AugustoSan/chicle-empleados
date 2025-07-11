import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class AddSaleController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final ValueNotifier<Customer?> customer = ValueNotifier<Customer?>(null);

  bool  _loading = false;
  String? _error;

  bool  get loading => _loading;
  String? get error => _error;


  final SalesRepository _saleRepository;
  final UserProvider _userProvider;
  final CustomerProvider _customerProvider;

  AddSaleController(this._saleRepository, this._userProvider, this._customerProvider);
  
  Future<String> saveSale(BuildContext context) async {
    _loading = true;
    _error   = null;
    notifyListeners();

    final user = await _userProvider.getCurrentUser();
    if (user == null) {
      _error = 'Usuario no encontrado';
      return _error!;
    }

    final res = await _saleRepository.saveSale(
      Sales.withoutId(
        userId: user.id, 
        customer: nameC.text == '' ? '0000000000' : nameC.text, 
        status: EnumSalesStatus.pending, 
        date: DateTime.now(), 
        items: []
      )
    );
    if(res == -1) {
      _error = 'Ocurrio un error al guardar';
      return _error!;
    }
    _loading = false;
    notifyListeners();
    return _error!;
  }

  Future<String> addItems(BuildContext context, int saleId, List<SaleItemMenu> items) async {
    
    return '';
  }

  Future<void> saveOrder(List<SaleItemMenu> items) async {
    notifyListeners();
  }

  Future<List<Customer>> searchCustomer(String filter) async {
    final customers = await _customerProvider.searchCustomer(filter);
    print('Customers: $customers');
    notifyListeners();
    return customers;
  }

  @override
  void dispose() {
    nameC.dispose();
    super.dispose();
  }
}
