import 'dart:io';
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
        subtitle: Column(
          children: [
            Text('\$ ${item.price.toStringAsFixed(2)}'),
            item.imageUrl != null
                ? Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey.shade200,
                    ),
                    alignment: Alignment.center,
                    child: ClipRRect(
                      child: Image.file(
                        File(item.imageUrl!),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const Text('Sin foto'),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Aquí podrías navegar a detalle del ítem
        },
      ),
    );
  }
}