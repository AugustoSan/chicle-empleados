import 'dart:io';
import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
// import 'package:chicle_app_empleados/presentation/screens/modules/update_menu.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class CardAddOrderItemCustom extends StatelessWidget {
  // final MenuItem item;
  final OrderItem orderItem;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CardAddOrderItemCustom({super.key, required this.orderItem, required this.onIncrement, required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    final bool mostrarImagen =
        orderItem.product.imageUrl != null && File(orderItem.product.imageUrl!).existsSync();

      return ListTile(
        onTap: () async {
          String? description = await agregarDescripcionOrdenMenuItemDialog(context, orderItem.specialIndications ?? '');
          orderItem.specialIndications = description;
        },
      leading: mostrarImagen ? Image.file(File(orderItem.product.imageUrl!), width: 40, height: 40) : const SizedBox.shrink(),
      title: Text(orderItem.product.name),
      subtitle: Text('\$${orderItem.product.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: onDecrement,
          ),
          Text('${orderItem.quantity}'),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: onIncrement,
          ),
        ],
      ),
    );
    // return InkWell(
    //   onTap: () => mostrarMenuItemDialog(context, item),
    //   onLongPress: () => mostrarMenuItemDialog(context, item),
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
