import 'package:flutter/material.dart';
import './modules.dart';

/// Pantalla que muestra dos secciones: Bebidas y Menús.
/// Usa un BottomNavigationBar para alternar entre ellas.
class MenuItemsListScreen extends StatelessWidget {
  const MenuItemsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final orientation = MediaQuery.of(context).orientation;
    print('orientation: $orientation');

    return orientation == Orientation.portrait
        ? MenuItemsListPortrait()
        : MenuItemsListLandscape();
  }
}

