import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation.dart';

/// Pantalla que muestra dos secciones: Bebidas y Menús.
/// Usa un BottomNavigationBar para alternar entre ellas.
class ProductsPortrait extends StatelessWidget {
  const ProductsPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Escucha los cambios en CategoryProvider. Cuando `loadAll` termine y llame a
    // `notifyListeners`, este widget se reconstruirá con los datos.
    final categoryProvider = context.watch<CategoryProvider>();
    final categories = categoryProvider.allItems;
    
    // Mientras se cargan los datos, `categories` estará vacío.
    // Mostramos un indicador de carga.
    if (categories.isEmpty) {
      // Podríamos añadir un estado de carga en el provider para ser más explícitos,
      // pero comprobar si la lista está vacía funciona para el caso inicial.
      return const Center(child: CircularProgressIndicator());
    }
    
    return ListView(
      children: [
        // Mapea directamente la lista de categorías del provider a los widgets.
        ...categories.map((category) =>
            MenuCarousel(items: category.items, title: category.name))
      ],
    );
  }
}
