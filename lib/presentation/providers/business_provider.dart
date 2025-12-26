// lib/presentation/providers/business_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class BusinessProvider with ChangeNotifier {
  final BusinessRepository _repo;
  bool _initialized = false;

  Business? _business;
  Business? get business => _business;

  BusinessProvider(this._repo);

  Future<void> initialize() async {
    if (_initialized) return;
    await _repo.initialize();
    _initialized = true;
  }

  Future<void> loadBusinessData() async {
    _business = await _repo.loadBusiness();
    notifyListeners();
  }

  Future<void> updateBusinessName(String name) async {
    if (_business != null) {
      _business = _business!.copyWith(name: name);
      await _repo.saveBusiness(_business!);
      notifyListeners();
    }
  }

  Future<void> updateBusinessType(BusinessType type) async {
    if (_business != null) {
      _business = _business!.copyWith(type: type);
      await _repo.saveBusiness(_business!);
      notifyListeners();
    }
  }

  Future<void> changeCashInit(double initialCash) async {
    if (_business != null) {
      _business = _business!.copyWith(initialCash: initialCash);
      await _repo.saveBusiness(_business!);
      notifyListeners();
    }
  }

  Future<bool> saveBusiness(Business config) async {
    _business = config;
    await _repo.saveBusiness(config);
    notifyListeners();
    return true;
  }
}
