import 'dart:io';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/presentation/screens/modules/update_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/menuItem.dart';

class CardMenuCustom extends StatelessWidget {
  final MenuItem item;
  const CardMenuCustom({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final navigatorKey = context.watch<ShellNavigatorController>();
    final bool mostrarImagen = item.imageUrl != null && File(item.imageUrl!).existsSync();
    return InkWell(
      onLongPress: () {
        showDialog<void>(
          context: context,
          barrierDismissible: true, // permite cerrar tocando fuera
          builder: (ctx) {
            return AlertDialogShow(item: item);
          },
        );
      },
      onTap: () {
        navigatorKey.navigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (ctx) => UpdateMenuItemController(ctx.read<MenuItemProvider>(), item),
              child: const UpdateMenuScreen()
            )
          )
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título y subtítulo
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('\$ ${item.price.toStringAsFixed(2)}'),
              ),

              if (mostrarImagen)
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(12)),
                    child: SizedBox(
                      height: 80,                     // un poco menos
                      width: double.infinity,
                      child: Image.file(
                        File(item.imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 8),

              // Descripción con padding
              Text(
                item.description ?? 'Sin descripción',
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,                      // límite de líneas
                overflow: TextOverflow.ellipsis,  // para que no crezca infinitamente
              ),
            ],
          ),
        )
      ),
    );
  }
}