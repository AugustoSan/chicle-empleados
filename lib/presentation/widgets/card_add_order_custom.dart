import 'dart:io';
import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
// import 'package:chicle_app_empleados/presentation/screens/modules/update_menu.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class CardAddOrderItemCustom extends StatelessWidget {
  // final MenuItem item;
  final OrderItem orderItem;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Function(String?) onAddDescription;

  const CardAddOrderItemCustom({super.key, required this.orderItem, required this.onIncrement, required this.onDecrement, required this.onAddDescription});

  @override
  Widget build(BuildContext context) {
    final bool mostrarImagen =
        orderItem.product.imageUrl != null && File(orderItem.product.imageUrl!).existsSync();

      return Container(
        child: Column(
          children: [
            ListTile(
                onTap: () async {
                  String? description = await agregarDescripcionOrdenMenuItemDialog(context, orderItem.specialIndications ?? '');
                  orderItem.specialIndications = description;
                  onAddDescription(description);
                },
              leading: mostrarImagen ? Image.file(File(orderItem.product.imageUrl!), width: 40, height: 40) : const SizedBox.shrink(),
              title: Text(orderItem.product.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${orderItem.product.price}'),
                  orderItem.specialIndications != null && orderItem.specialIndications!.isNotEmpty
                    ? Text(
                      orderItem.specialIndications != null && orderItem.specialIndications!.isNotEmpty
                          ? '${orderItem.specialIndications}'
                          : 'Sin indicaciones especiales',
                      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey),
                    )
                    : const SizedBox.shrink(),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: onDecrement,
                  ),
                  Text('${orderItem.quantity}'),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: onIncrement,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
