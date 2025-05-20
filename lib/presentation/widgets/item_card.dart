// Card genérico para Bebidas/Alimentos
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
    return Container(
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
    );
  }
}