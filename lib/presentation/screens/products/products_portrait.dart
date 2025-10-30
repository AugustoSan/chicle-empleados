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
          return Center(
            child: TextButton.icon(
              label: Text('Cargar productos'), 
              onPressed: () async {
                await categoryProvider.loadAndUpdateCategories();
              }, 
              icon: Icon(Icons.replay_outlined)
              ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            // Recarga las categorías
            await categoryProvider.loadAndUpdateCategories();
          },
          color: Theme.of(context).primaryColor, // color del círculo
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(), // permite el pull incluso si la lista no tiene scroll
            children: [
              ...categories.map(
                (category) => MenuCarousel(
                  items: category.items,
                  title: category.name,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
