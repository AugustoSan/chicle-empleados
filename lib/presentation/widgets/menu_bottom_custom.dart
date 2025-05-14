import 'package:flutter/material.dart';

/// BottomNavigationBar con dos pestañas: Bebidas y Menús
class MenuBottomCustom extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MenuBottomCustom({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.local_cafe),
          label: 'Bebidas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu),
          label: 'Menús',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt),
          label: 'Órdenes',
        ),
      ],
    );
  }
}
