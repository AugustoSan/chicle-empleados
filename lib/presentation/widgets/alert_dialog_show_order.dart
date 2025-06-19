import 'package:flutter/material.dart';
import './../presentation.dart';
import '../../domain/domain.dart';

class AlertDialogShowOrder extends StatelessWidget {
  final Sales item;
  const AlertDialogShowOrder({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Orden # ${item.id} '),
      content: Column(
        mainAxisSize: MainAxisSize.min,  // para que el dialog se ajuste al contenido
        children: [
          Text(item.status.toString()),
          const SizedBox(height: 12),
          Text(PriceUtils.formatPrice(item.total)),
          ...item.items.map((menu) => Text('${menu.quantity.toString()}  ${menu.menuItem.name}')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}