import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../domain/entities/menuItem.dart';

class AlertDialogShow extends StatelessWidget {
  final MenuItem item;
  const AlertDialogShow({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mostrarImagen = item.imageUrl != null && File(item.imageUrl!).existsSync();
    return AlertDialog(
      title: Text(item.name),
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
                    ? Image.file(File(item.imageUrl!), fit: BoxFit.cover)
                    : const SizedBox.shrink(),
              ),
            ),
          const SizedBox(height: 12),
          Text(item.description?.isEmpty ?? true ? 'Sin descripción' : item.description!),
          const SizedBox(height: 12),
          Text('Precio: ${PriceUtils.getStringPrice(item.price)}'),
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