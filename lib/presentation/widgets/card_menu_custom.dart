import 'package:flutter/material.dart';
import '../../domain/entities/menuItem.dart';

class CardMenuCustom extends StatelessWidget {
  final MenuItem item;
  const CardMenuCustom({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(
          item.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(item.price.toString()),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Aquí podrías navegar a detalle del ítem
        },
      ),
    );
  }
}