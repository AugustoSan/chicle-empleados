import 'package:chicle_app_empleados/presentation/presentation.dart';
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
        TextButton(
          onPressed: () {
            saleProvider.cancelSale(item);
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar cuenta'),
        ),
        TextButton(
          onPressed: () {
            saleProvider.completeSale(item);
            Navigator.of(context).pop();
          },
          child: const Text('Finalizar cuenta'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Agregar de la carta'),
        ),
      ],
    );
  }
}