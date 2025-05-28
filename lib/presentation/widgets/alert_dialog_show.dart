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
        mainAxisSize: MainAxisSize.min,  // para que el dialog se ajuste al contenido
        children: [
          if (mostrarImagen) 
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(item.imageUrl!),
                width: 200,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 12),
          Text(item.description?.isEmpty ?? true ? 'Sin descripción' : item.description!),
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