import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../../domain/domain.dart';
import '../../presentation.dart';

/// Pantalla que muestra dos secciones: Bebidas y Menús.
/// Usa un BottomNavigationBar para alternar entre ellas.
class MenuItemsListPortrait extends StatefulWidget {
  const MenuItemsListPortrait({Key? key}) : super(key: key);

  @override
  State<MenuItemsListPortrait> createState() => _MenuItemsListPortraitState();
}

class _MenuItemsListPortraitState extends State<MenuItemsListPortrait> {
  @override
  void initState() {
    super.initState();
    context.read<MenuItemProvider>().loadAll();
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MenuItemProvider>();
    final menuList = provider.menus;
    final bebidasList = provider.bebidas;
    final alimentosList = provider.alimentos;
    final extraList = provider.extras;

    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MenuCarousel(
          items: menuList,
          title: 'Menús',
        ),

        MenuCarousel(
          items: bebidasList,
          title: 'Bebidas',
        ),

        MenuCarousel(
          items: alimentosList,
          title: 'Alimentos',
        ),

        MenuCarousel(
          items: extraList,
          title: 'Extras',
        ),
      ],
    );
  }
}

