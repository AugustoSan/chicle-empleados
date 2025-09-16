import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/presentation/screens/orders/update_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import './../presentation.dart';
import '../../domain/domain.dart';

class AlertDialogShowSale extends StatelessWidget {
  final Sales item;
  const AlertDialogShowSale({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final saleProvider = context.read<SaleProvider>();
    return AlertDialog(
      title: Text('¿Que quieres hacer?'),
      // content: Column(
      //   mainAxisSize: MainAxisSize.min,  // para que el dialog se ajuste al contenido
      //   children: [
      //     Text(item.status.toString()),
      //     const SizedBox(height: 12),
      //     Text(PriceUtils.formatPrice(item.total)),
      //     ...item.items.map((menu) => Text('${menu.quantity.toString()}  ${menu.menuItem.name}')),
      //   ],
      // ),
      actions: [
        TextButton.icon(
          onPressed: () {
            saleProvider.cancelSale(item);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.cancel, color: Colors.red, size: 13),
          label: const Text('Cancelar', style: TextStyle(color: Colors.red, fontSize: 13)),
        ),
        TextButton.icon(
          onPressed: () {
            saleProvider.completeSale(item);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.done, color: Colors.green, size: 13),
          label: const Text('Finalizar', style: TextStyle(color: Colors.green, fontSize: 13)),
        ),
        TextButton.icon(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateOrder(sale: item))), 
          icon: const Icon(Icons.edit, color: Colors.black, size: 13),
          label: const Text('Editar', style: TextStyle(color: Colors.black, fontSize: 13))),
      ],
    );
  }
}