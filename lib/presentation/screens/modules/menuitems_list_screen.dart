import 'package:chicle_app_empleados/presentation/widgets/card_menu_custom.dart';
import 'package:flutter/material.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

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

  // Alimentos
  final List<MenuItem> _alimentos = [
    MenuItem(
      name: 'Sandwich',
      price: 30.0,
      category: 'alimento',
      imageUrl: 'https://via.placeholder.com/80x80.png?text=Sandwich',
    ),
    MenuItem(
      name: 'Cuernito',
      price: 28.0,
      category: 'alimento',
      imageUrl: 'https://via.placeholder.com/80x80.png?text=Cuernito',
    ),
    MenuItem(
      name: 'Baguette',
      price: 25.0,
      category: 'alimento',
      imageUrl: 'https://via.placeholder.com/80x80.png?text=Baguette',
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

    final orientation = MediaQuery.of(context).orientation;
    print('orientation: $orientation');

    return orientation == Orientation.portrait
        ? ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: currentList.length,
            itemBuilder: (context, index) {
              final item = currentList[index];
              return CardMenuCustom(item: item);
        },
      )
      : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // — Bebidas —
            Expanded(
              child: Column(
                children: [
                  const SectionTitle('Bebidas'),
                  const SizedBox(height: 8),
                  GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _bebidas.map((item) {
                      return ItemCard(
                        item: item,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // — Alimentos —
            Expanded(
              child: Column(
                children: [
                  const SectionTitle('Alimentos'),
                  const SizedBox(height: 8),
                  GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _alimentos.map((item) {
                      return ItemCard(
                        item: item,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),


            // — Menús —
            Expanded(
              child: Column(
                children: [
                  const SectionTitle('Menús'),
                  const SizedBox(height: 8),
                  Column(
                    children: _menus.map((item) {
                      final isFeatured = item.name == 'Especial del Día';
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                          color: isFeatured ? Colors.white : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.name,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: isFeatured ? 18 : 16,
                            fontWeight: isFeatured ? FontWeight.bold : FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  }
}

