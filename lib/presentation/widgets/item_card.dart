// Card genérico para Bebidas/Alimentos
// import 'dart:io';

import 'package:flutter/material.dart';
import '../../domain/entities/menuItem.dart';

class ItemCard extends StatelessWidget {
  final MenuItem item;

  const ItemCard({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: item.imageUrl != null
      //     ? Container(
      //         width: 100,
      //         height: 100,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Colors.grey.shade200,
      //         ),
      //         alignment: Alignment.center,
      //         child: ClipOval(
      //           child: Image.file(
      //             File(item.imageUrl!),
      //             width: 100,
      //             height: 100,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       )
      //     : const Icon(Icons.person),
      subtitle: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // File(item.imageUrl ?? '', style: const TextStyle(fontSize: 36)),
          const SizedBox(height: 8),
          Text(
            item.name,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    ),
    );
  }
}