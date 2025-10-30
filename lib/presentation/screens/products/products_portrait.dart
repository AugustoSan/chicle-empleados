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
            child: ButtonLoadProducts(),
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


class ButtonLoadProducts extends StatefulWidget{
  const ButtonLoadProducts({super.key,});

  @override
  State<ButtonLoadProducts> createState() => _ButtonLoadProductsState();
}

class _ButtonLoadProductsState extends State<ButtonLoadProducts> {
  bool _loading = false;

  Future<void> _loadCategories() async {
    setState(() {
      _loading = true;
    });
    final menuProv = context.read<CategoryProvider>();
    await menuProv.loadAndUpdateCategories();

    setState(() {
      _loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return _loading 
      ? const Center(child: CircularProgressIndicator()) 
      : TextButton.icon(
      onPressed: _loadCategories,
      label: const Text('Cargar productos'),
      icon: const Icon(Icons.replay_outlined),
    );
  }
}