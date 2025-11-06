// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class CashCutProvider with ChangeNotifier {
  final CashCutRepository _repo;
  List<CashCut> _allItems = [];
  bool _loading = false;

  bool get loading => _loading;

  CashCutProvider(this._repo);

  // Llama esto en initState de tu pantalla o nada más instanciar el provider
  Future<void> saveCashCut(CashCut cashCut) async {
    await _repo.saveCashCut(cashCut);
    notifyListeners();
  }

  Future<void> getAllCashCuts() async {
    _allItems = await _repo.getAllCashCuts();
    notifyListeners();
  }

  List<CashCut> get allItems => _allItems;

  Future<CashCut?> getCashCut(String id) async {
    final category = await _repo.getCashCut(id);
    notifyListeners();
    return category;
  }

  Future<void> updateCashCut(String id, CashCut cashCut) async {
    await _repo.updateCashCut(id, cashCut);
    notifyListeners();
  }

  Future<void> deleteCashCut(String id) async {
    await _repo.deleteCashCut(id);
    notifyListeners();
  }

  Future<CashCut?> getLastCashCut() async {
    final category = await _repo.getLastCashCut();
    notifyListeners();
    return category;
  }
}
