import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';

class ListItemsPriceQuantity extends StatelessWidget {
  final Map<Product,OrderItem> saleItems;
  final List<Product> listProducts;

  const ListItemsPriceQuantity({
    Key? key,
    required this.saleItems,
    required this.listProducts,
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
            key: ValueKey(item.id), // Añade esta línea
            item: item,
          );
        },
      ),
    );
  }
}