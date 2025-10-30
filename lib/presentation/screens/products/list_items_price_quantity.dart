import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';

class ListItemsPriceQuantity extends StatelessWidget {
  final Map<Product,OrderItem> saleItems;
  final List<Product> listProducts;
  final VoidCallback onQuantityChanged;

  const ListItemsPriceQuantity({
    Key? key,
    required this.saleItems,
    required this.listProducts,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: saleItems.length,
        itemBuilder: (context, index) {
          final menuItem = listProducts[index];
          final item = saleItems[menuItem];
          if (item == null) {
            return const SizedBox.shrink();
          }
          return CardAddOrderItemCustom(
            key: ValueKey(item.id),
            item: item,
            onQuantityChanged: onQuantityChanged,
          );
        },
      ),
    );
  }
}