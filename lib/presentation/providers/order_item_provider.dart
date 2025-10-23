// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class OrderItemProvider with ChangeNotifier {
  final OrderItemRepository _repo;

  OrderItemProvider(this._repo);

  // Llama esto en initState de tu pantalla o nada más instanciar el provider
  Future<List<OrderItem>> loadItemsByOrder(String id) async {
    return await _repo.getItemsByOrder(id);
  }

  Future<OrderItem?> getOrder(String id) async {
    final sale = await _repo.getOrderItem(id);
    return sale;
  }
}
