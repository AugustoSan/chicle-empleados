import 'package:flutter/material.dart';
import 'package:chicle_app_empleados/domain/domain.dart';

class CashCutViewModel extends ChangeNotifier {
  final CashCutRepository _repository;

  CashCutViewModel({required CashCutRepository repository})
      : _repository = repository;

  List<CashCut> _cashCuts = [];
  bool _isLoading = false;
  String? _error;
  bool _hasError = false;

  List<CashCut> get cashCuts => _cashCuts;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _hasError;

  Future<void> loadCashCuts() async {
    if(_isLoading ) return;
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _cashCuts = await _repository.getAllCashCuts();
      notifyListeners();
    } catch (e) {
      print('Error fetching cash cuts: $e');
      _hasError = true;
      _error = 'Error al cargar cortes de caja: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadCashCuts();
  }

}