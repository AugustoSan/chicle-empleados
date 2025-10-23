import 'package:chicle_app_empleados/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class MenuCarousel extends StatelessWidget {
  final List<Product> items;
  final String title;
  const MenuCarousel({Key? key, required this.items, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( 
      margin: const EdgeInsets.all(8),               // margen exterior
      padding: const EdgeInsets.symmetric(vertical: 16), // padding interior
      decoration: BoxDecoration(
        color: Colors.grey.shade100,                   // color de fondo suave
        borderRadius: BorderRadius.circular(12),       // esquinas redondeadas
      ),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título del carrusel
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Carrusel horizontal
        SizedBox(
          height: items.isNotEmpty ? 240 : 20,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return CardProductCustom(item: item);
            },
          ),
        ),
      ],
    ));
  }
}