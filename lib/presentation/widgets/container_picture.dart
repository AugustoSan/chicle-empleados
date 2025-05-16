import 'dart:io';
import 'package:flutter/material.dart';

class ContainerPicture extends StatelessWidget {
  final String? rutaImagen; // puede ser null

  const ContainerPicture({super.key, this.rutaImagen});

  @override
  Widget build(BuildContext context) {
    final bool mostrarImagen = rutaImagen != null && File(rutaImagen!).existsSync();

    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
      ),
      alignment: Alignment.center,
      child: mostrarImagen
          ? ClipOval(
              child: Image.file(
                File(rutaImagen!),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            )
          : const Text(
              'Sin imagen',
              style: TextStyle(color: Colors.black54),
            ),
    );
  }
}
