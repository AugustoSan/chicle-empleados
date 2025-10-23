import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AlertDialogAddDescrptionProduct extends StatelessWidget {
  // final OrderItem orderItem;
  final Product product;
  const AlertDialogAddDescrptionProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // final product = orderItem.product;
    final mostrarImagen = product.imageUrl != null && File(product.imageUrl!).existsSync();
    return AlertDialog(
      title: Text(product.name),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,  // para que el dialog se ajuste al contenido
        children: [
          if (mostrarImagen) 
            ClipRRect(
              borderRadius:
                  const BorderRadius.all(Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 1,
                child: mostrarImagen
                    ? Image.file(File(product.imageUrl!), fit: BoxFit.cover)
                    : const SizedBox.shrink(),
              ),
            ),
          const SizedBox(height: 12),
          Text(product.description?.isEmpty ?? true ? 'Sin descripción' : product.description!),
          const SizedBox(height: 12),
          Text('Precio: ${PriceUtils.getStringPrice(product.price)}'),
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