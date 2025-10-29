import 'package:flutter/material.dart';
import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';

Future<void> mostrarProductDialog(BuildContext context, Product item) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => AlertDialogShow(item: item),
  );
}

Future<String?> agregarDescripcionOrdenMenuItemDialog(BuildContext context, String indications) {
  return showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (_) => AlertDialogAddDescrptionOrderMenuItem(indications: indications),
  );
}

Future<void> mostrarDescriptionOrderItemDialog(BuildContext context, Product item) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => AlertDialogAddDescrptionProduct(product: item),
  );
}

Future<void> mostrarSaleDialog(BuildContext context, Order item) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => AlertDialogShowOrder(item: item),
  );
}

Future<void> mostrarTicketDialog(BuildContext context, Order item) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => ReceiptWidget(data: item),
  );
}

Future<bool?> mostrarDeleteDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Eliminar'),
        content: const Text('¿Estás seguro de eliminarlo?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: const Text('Eliminar'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
    },
  );
}

Future<void> mostrarQrImageDialog(BuildContext context, String message) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => AlertQrDialog(message: message),
  );
}