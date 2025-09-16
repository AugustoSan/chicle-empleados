import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

/// Pantalla que muestra dos secciones: Bebidas y Menús.
/// Usa un BottomNavigationBar para alternar entre ellas.
class MenuItemsListPortrait extends StatefulWidget {
  const MenuItemsListPortrait({Key? key}) : super(key: key);

  @override
  State<MenuItemsListPortrait> createState() => _MenuItemsListPortraitState();
}

class _MenuItemsListPortraitState extends State<MenuItemsListPortrait> {
  List<MenuItem> menuList = [];
  List<MenuItem> bebidasList = [];
  List<MenuItem> alimentosList = [];
  List<MenuItem> extraList = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    menuList.clear();
    bebidasList.clear();
    alimentosList.clear();
    extraList.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _init() async {
    final provider = context.read<MenuItemProvider>();
    await provider.loadAll();

    if (!mounted) return;

    final items = provider.allItems;

    setState(() {
      menuList.clear();
      bebidasList.clear();
      alimentosList.clear();
      extraList.clear();
      menuList = items.where((item) => item.category == EnumMenuItemCategory.menu).toList();
      bebidasList = items.where((item) => item.category == EnumMenuItemCategory.bebida).toList();
      alimentosList = items.where((item) => item.category == EnumMenuItemCategory.alimento).toList();
      extraList = items.where((item) => item.category == EnumMenuItemCategory.extra).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<MenuItemProvider>();
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

