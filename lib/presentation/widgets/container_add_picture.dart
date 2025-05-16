import 'dart:io';
import 'package:flutter/material.dart';

class ContainerAddPicture extends StatelessWidget {
  
  final VoidCallback onSaveImage;
  final String? rutaImagen; // puede ser null
  ContainerAddPicture({super.key, required this.onSaveImage, this.rutaImagen});


  @override
  Widget build(BuildContext context) {
    final bool mostrarImagen = rutaImagen != null && File(rutaImagen!).existsSync();
    return Container(
          height: 160,
          alignment: Alignment.center,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                child: mostrarImagen
                    ? ClipOval(
                        child: Image.file(
                          File(rutaImagen!),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Text('Sin foto'),
                backgroundColor: Colors.grey.shade200,
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_a_photo),
                label: const Text('Seleccionar imagen'),
                onPressed: onSaveImage,
              ),
            ],
          ),
          // mostrarImagen
          //     ? ClipOval(
          //         child: Image.file(
          //           File(rutaImagen!),
          //           width: 100,
          //           height: 100,
          //           fit: BoxFit.cover,
          //         ),
          //       )
          //     : IconButton(
          //         icon: const Icon(Icons.add_a_photo),
          //         onPressed: onSaveImage,
          //       ),
        );
  }
}
