import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class AddSaleController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();

  bool  _loading = false;
  String? _error;

  bool  get loading => _loading;
  String? get error => _error;


  final SalesRepository _saleRepository;
  final UserProvider _userProvider;

  AddSaleController(this._saleRepository, this._userProvider);
  
  Future<String> saveSale(BuildContext context) async {
    
    final error = validate();
    if (error != '') {
      _error = error;
      return error;
    }
    _loading = true;
    _error   = null;
    notifyListeners();

    final user = await _userProvider.getCurrentUser();
    if (user == null) {
      _error = 'Usuario no encontrado';
      return error;
    }

    final res = await _saleRepository.saveSale(
      Sales.withoutId(
        userId: user.id, 
        consumer: nameC.text, 
        status: EnumSalesStatus.pending, 
        date: DateTime.now(), 
        items: []
      )
    );
    if(res == -1) {
      _error = 'Ocurrio un error al guardar';
      return error;
    }
    _loading = false;
    notifyListeners();
    return error;
  }

  Future<String> addItems(BuildContext context, int saleId, List<SaleItemMenu> items) async {
    
    return '';
  }

  Future<void> saveOrder(List<SaleItemMenu> items) async {
    notifyListeners();
  }

  String validate() {
    if(nameC.text.isEmpty) return 'Nombre inválido';
    return '';
  }

  @override
  void dispose() {
    nameC.dispose();
    super.dispose();
  }
}
