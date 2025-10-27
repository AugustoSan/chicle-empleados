import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../../domain/domain.dart';
import '../../presentation.dart';

/// Pantalla que muestra dos secciones: Bebidas y Menús.
/// Usa un BottomNavigationBar para alternar entre ellas.
class MenuItemsListLandscape extends StatefulWidget {
  MenuItemsListLandscape({Key? key}) : super(key: key);

  @override
  State<MenuItemsListLandscape> createState() => _MenuItemsListLandscapeState();
}

class _MenuItemsListLandscapeState extends State<MenuItemsListLandscape> {
  @override
  void initState() {
    super.initState();
    context.read<ProductProvider>().loadAll();
  }
  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<ProductProvider>();
    // final menuList = provider.menus;
    // final bebidasList = provider.bebidas;
    // final alimentosList = provider.alimentos;
    // final extraList = provider.extras;

    // print('menuList: ${menuList.length}');
    // print('bebidasList: ${bebidasList.length}');
    // print('alimentosList: ${alimentosList.length}');
    // print('extraList: ${extraList.length}');

    // if(menuList.isEmpty && bebidasList.isEmpty && alimentosList.isEmpty && extraList.isEmpty) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // — Menús —
        SizedBox(
          width: 200,
          child: ListView(
            children: [
              const SectionTitle('Menús'),
              const SizedBox(height: 8),
              Expanded(
                // para mantener scroll en caso de muchos ítems
                // child: ListView.builder(
                //       itemCount: menuList.length,
                //       itemBuilder: (context, index) {
                //         final item = menuList[index];
                //         return CardProductCustomLandscape(item: item);
                //       },
                //     ),
                child: Text('Menús'),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

      ],
    );
  }
}

