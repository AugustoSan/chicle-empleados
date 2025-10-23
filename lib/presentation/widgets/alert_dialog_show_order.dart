import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/presentation/screens/orders/update_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import './../presentation.dart';
import '../../domain/domain.dart';

class AlertDialogShowOrder extends StatelessWidget {
  final Order item;
  const AlertDialogShowOrder({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.read<OrderProvider>();
    return AlertDialog(
      title: Text('¿Que quieres hacer?'),
      actions: [
        TextButton.icon(
          onPressed: () {
            orderProvider.cancelOrder(item);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.cancel, color: Colors.red, size: 13),
          label: const Text('Cancelar', style: TextStyle(color: Colors.red, fontSize: 13)),
        ),
        TextButton.icon(
          onPressed: () {
            orderProvider.completeOrder(item);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.done, color: Colors.green, size: 13),
          label: const Text('Finalizar', style: TextStyle(color: Colors.green, fontSize: 13)),
        ),
        TextButton.icon(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateOrder(idOrder: item.id))), 
          icon: const Icon(Icons.edit, color: Colors.black, size: 13),
          label: const Text('Editar', style: TextStyle(color: Colors.black, fontSize: 13))),
      ],
    );
  }
}