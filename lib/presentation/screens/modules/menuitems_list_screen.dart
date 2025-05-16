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

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Selecciona la lista según la pestaña activa
    final List<MenuItem> currentList =
        _selectedIndex == 0 ? _bebidas : _menus;

    // Títulos dinámicos
    // final titles = ['Bebidas', 'Menús'];

    return ListView.builder(
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
      );
  }
}

