import 'dart:io';
import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
// import 'package:chicle_app_empleados/presentation/screens/modules/update_menu.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class CardAddOrderItemCustom extends StatefulWidget {
  final OrderItem item;
  final VoidCallback onQuantityChanged;

  const CardAddOrderItemCustom({super.key, required this.item, required this.onQuantityChanged});

  @override
  State<CardAddOrderItemCustom> createState() => _CardAddOrderItemCustomState();
}

class _CardAddOrderItemCustomState extends State<CardAddOrderItemCustom> {

  late OrderItem orderItem;
  // final MenuItem item;
  // final VoidCallback onIncrement;
  // final VoidCallback onDecrement;
  // final Function(String?) onAddDescription;

  @override
  void initState() {
    super.initState();
    orderItem = widget.item;
  }

  void onIncrement() {
    if (orderItem.quantity >= 1000) return;
    setState(() {
      orderItem.quantity += 1;
    });
    widget.onQuantityChanged.call();
  }

  void onDecrement() {
    if (orderItem.quantity <= 0) return;
    setState(() {
      orderItem.quantity -= 1;
    });
    widget.onQuantityChanged.call();
  }

  void onAddDescription(String? description) {
    setState(() {
      orderItem.specialIndications = description;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool mostrarImagen =
        orderItem.product.imageUrl != null && (orderItem.product.imageUrl!.contains('http') ? true : File(orderItem.product.imageUrl!).existsSync());

    final bool isImageNet =
        orderItem.product.imageUrl != null && orderItem.product.imageUrl!.contains('http');


      return Container(
        child: Column(
          children: [
            ListTile(
                onTap: () async {
                  String? description = await agregarDescripcionOrdenMenuItemDialog(context, orderItem.specialIndications ?? '');
                  orderItem.specialIndications = description;
                  onAddDescription(description);
                },
              leading: mostrarImagen 
                ? isImageNet 
                  ? Image.network(orderItem.product.imageUrl!, width: 40, height: 40)
                  : Image.file(File(orderItem.product.imageUrl!), width: 40, height: 40) : const SizedBox.shrink(),
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
