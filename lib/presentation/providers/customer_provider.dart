// lib/presentation/providers/business_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class CustomerProvider with ChangeNotifier {
  final CustomerRepository _repo;
  bool _initialized = false;

  List<Customer> _customers = [];
  List<Customer> get customers => _customers;

  CustomerProvider(this._repo) {
    loadCustomerData();
  }

  Future<void> initialize() async {
    if (_initialized) return;
    await _repo.initialize();
    _initialized = true;
  }

  Future<void> loadCustomerData() async {
    _customers = await _repo.getAll(CustomerFilter());
    notifyListeners();
  }

  Future<List<Customer>> searchCustomer(String filter) async {
    final customers = await _repo.getAll(CustomerFilter(name: filter, phone: filter, email: filter));
    return customers;
  }

  // Future<void> updateCustomerName(String name) async {
    
  // }

  Future<bool> saveCustomer(Customer customer) async {
    await _repo.create(customer);
    notifyListeners();
    return true;
  }
}
