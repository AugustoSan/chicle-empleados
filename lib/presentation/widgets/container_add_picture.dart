import 'dart:io';
import 'package:flutter/material.dart';

class ContainerAddPicture extends StatelessWidget {
  final String? rutaImagen; // puede ser null

  const ContainerAddPicture({super.key, this.rutaImagen});

  @override
  Widget build(BuildContext context) {
    final bool mostrarImagen = rutaImagen != null && File(rutaImagen!).existsSync();

    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.secondary,
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
              : IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: () {},
                ),
        ),
      ]
    );
  }
}
