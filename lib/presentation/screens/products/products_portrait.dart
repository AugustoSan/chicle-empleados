import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation.dart';

class ProductsPortrait extends StatelessWidget {
  const ProductsPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Usar Consumer para reconstruir solo la lista cuando los datos cambien.
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        final categories = categoryProvider.allItems;
        if (categories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            ...categories.map((category) =>
                MenuCarousel(items: category.items, title: category.name))
          ],
        );
      },
    );
  }
}
