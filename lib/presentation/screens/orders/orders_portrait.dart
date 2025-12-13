import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';

class OrdersPortrait extends StatefulWidget {
  const OrdersPortrait({Key? key}) : super(key: key);

  @override
  State<OrdersPortrait> createState() => _OrdersPortraitState();
}

class _OrdersPortraitState extends State<OrdersPortrait> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    
    try {
      final orderProv = context.read<OrderProvider>();
      await orderProv.loadAll();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().allOrders;

    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _buildContent(orders),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(List<Order> orders) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orders.isEmpty) {
      return const Center(
        child: Text('No hay órdenes'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final item = orders[index];
          return CardOrderCustomPortrait(item: item);
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}