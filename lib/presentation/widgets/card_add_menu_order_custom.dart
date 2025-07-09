import 'dart:io';
import 'package:chicle_app_empleados/presentation/presentation.dart';
// import 'package:chicle_app_empleados/presentation/screens/modules/update_menu.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '../../domain/entities/menuItem.dart';

class CardAddMenuOrderCustom extends StatelessWidget {
  final MenuItem item;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CardAddMenuOrderCustom({super.key, required this.item, required this.quantity, required this.onIncrement, required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    final bool mostrarImagen =
        item.imageUrl != null && File(item.imageUrl!).existsSync();

      return ListTile(
        onTap: () {
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (_) => AlertDialogShow(item: item),
        );
      },
      leading: mostrarImagen ? Image.file(File(item.imageUrl!), width: 40, height: 40) : const SizedBox.shrink(),
      title: Text(item.name),
      subtitle: Text('\$${item.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: onDecrement,
          ),
          Text('${quantity}'),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: onIncrement,
          ),
        ],
      ),
    );
    // return InkWell(
    //   onTap: () {
    //     showDialog<void>(
    //       context: context,
    //       barrierDismissible: true,
    //       builder: (_) => AlertDialogShow(item: item),
    //     );
    //   },
    //   onLongPress: () {
    //     showDialog<void>(
    //       context: context,
    //       barrierDismissible: true,
    //       builder: (_) => AlertDialogShow(item: item),
    //     );
    //   },
    //   child: SizedBox(
    //     width: 160,
    //     height: 350,
    //     child: Container(
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(12),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.black.withOpacity(0.05),
    //           blurRadius: 8,
    //           offset: const Offset(0, 4),
    //         ),
    //       ],
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // Imagen superior
    //         ClipRRect(
    //           borderRadius:
    //               const BorderRadius.vertical(top: Radius.circular(12)),
    //           child: AspectRatio(
    //             aspectRatio: 4 / 2,
    //             child: mostrarImagen
    //                 ? Image.file(File(item.imageUrl!), fit: BoxFit.cover)
    //                 : const SizedBox.shrink(),
    //           ),
    //         ),

    //         const SizedBox(height: 8),

    //         // Nombre
    //         Flexible(
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 8),
    //             child: Text(
    //               item.name,
    //               style: const TextStyle(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //               maxLines: 1,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //           ),
    //         ),

    //         const SizedBox(height: 4),

    //         // Precio
    //         Flexible(
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 8),
    //             child: Text(
    //               PriceUtils.getStringPrice(item.price),
    //               style: TextStyle(fontSize: 14, color: Colors.grey[700]),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),),
    // );
  }
}
