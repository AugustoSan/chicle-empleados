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
    final comidaList = provider.comida;
    final extraList = provider.extras;

    if(menuList.isEmpty && bebidasList.isEmpty && comidaList.isEmpty && extraList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // — Menús —
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle('Menús'),
              const SizedBox(height: 8),
              Expanded(
                // para mantener scroll en caso de muchos ítems
                child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: menuList.length,
                      itemBuilder: (context, index) {
                        final item = menuList[index];
                        return CardMenuCustomLandscape(item: item);
                      },
                    ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // — Bebidas —
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle('Bebidas'),
              const SizedBox(height: 8),
              // El Expanded le da altura y el Expanded interior le da ancho
              Expanded(
                child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bebidasList.length,
                      itemBuilder: (context, index) {
                        final item = bebidasList[index];
                        return Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 8, left: 8, bottom: 12),
                          child: CardMenuCustom(item: item),
                        );
                      }
                    )
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // — Alimentos —
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle('Alimentos'),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: comidaList.length,
                      itemBuilder: (context, index) {
                        final item = comidaList[index];
                        return Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 8, left: 8, bottom: 12),
                          child: CardMenuCustom(item: item),
                        );
                      }
                    )
              ),
            ],
          ),
        ),
      ],
    );
  }
}

