// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:punto_venta/domain/entities/menuItem.dart';
// import 'package:punto_venta/presentation/providers/menuitem_provider.dart';

// class MenuItemsListScreen extends StatelessWidget {

//   MenuItemsListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final futureItems = context.read<MenuItemProvider>().getMenuItems();

//     return FutureBuilder<List<MenuItem>>(
//       future: futureItems,
//       builder: (ctx, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//         final menuitems = snapshot.data!;
//         return ListView.builder(
//           itemCount: menuitems.length,
//           itemBuilder: (context, index) {
//             final product = menuitems[index];
//             return ListTile(
//               title: Text(product.name),
//               subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
//               onTap: () { /* … */ },
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../domain/domain.dart';

/// Pantalla que muestra dos secciones: Bebidas y Menús.
/// Usa un BottomNavigationBar para alternar entre ellas.
class MenuItemsListScreen extends StatefulWidget {
  const MenuItemsListScreen({Key? key}) : super(key: key);

  @override
  State<MenuItemsListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuItemsListScreen> {
  int _selectedIndex = 0;

  // Datos de ejemplo
  final List<MenuItem> _bebidas = [
    MenuItem(
      name: 'Café Latte',
      price: 30.0,
      category: 'bebida',
      imageUrl: 'https://via.placeholder.com/80x80.png?text=Latte',
    ),
    MenuItem(
      name: 'Cappuccino',
      price: 28.0,
      category: 'bebida',
      imageUrl: 'https://via.placeholder.com/80x80.png?text=Cappuccino',
    ),
    MenuItem(
      name: 'Espresso',
      price: 25.0,
      category: 'bebida',
      imageUrl: 'https://via.placeholder.com/80x80.png?text=Espresso',
    ),
  ];

  final List<MenuItem> _menus = [
    MenuItem(
      name: 'Combo Desayuno',
      price: 75.0,
      category: 'menu',
      imageUrl: 'https://via.placeholder.com/80x80.png?text=Desayuno',
    ),
    MenuItem(
      name: 'Lunch Express',
      price: 90.0,
      category: 'menu',
      imageUrl: 'https://via.placeholder.com/80x80.png?text=Lunch',
    ),
    MenuItem(
      name: 'Tarde Dulce',
      price: 65.0,
      category: 'menu',
      imageUrl: 'https://via.placeholder.com/80x80.png?text=Tarde',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Selecciona la lista según la pestaña activa
    final List<MenuItem> currentList =
        _selectedIndex == 0 ? _bebidas : _menus;

    // Títulos dinámicos
    final titles = ['Bebidas', 'Menús'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: currentList.length,
        itemBuilder: (context, index) {
          final item = currentList[index];
          return Card(
            margin:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.imageUrl != null ? Image.network(
                  item.imageUrl!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ) : null,
              ),
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
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Bebidas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menús',
          ),
        ],
      ),
    );
  }
}

