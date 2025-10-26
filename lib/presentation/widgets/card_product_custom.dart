import 'dart:io';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class CardProductCustom extends StatelessWidget {
  final Product item;
  const CardProductCustom({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // final navigatorKey = context.watch<ShellNavigatorController>();
    final bool isImageNet = item.imageUrl != null && item.imageUrl!.contains('http');
    final bool mostrarImagen = item.imageUrl != null && (item.imageUrl!.contains('http') ? true : File(item.imageUrl!).existsSync());
    return InkWell(
      onLongPress: () => mostrarProductDialog(context, item),
      onTap: () {
        Navigator.push(context, RouteUtils().getRouteUpdateProduct(item));
      },
      child: Container(
        width: 160, // Ancho fijo para cada card
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            // Sombra suave
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen superior
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: mostrarImagen 
                  ? isImageNet 
                    ? Image.network(
                      item.imageUrl!,
                      fit: BoxFit.cover,
                    )
                    : Image.file(
                      File(item.imageUrl!),
                      fit: BoxFit.cover,
                    ) : const SizedBox.shrink(),
              ),
            ),
            // Espacio interno
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                PriceUtils.getStringPrice(item.price),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                item.description != null && !item.description!.isEmpty ? item.description! : 'Sin descripción',
                textAlign: TextAlign.justify,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}