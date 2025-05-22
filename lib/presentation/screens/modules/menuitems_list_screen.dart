import 'package:chicle_app_empleados/presentation/widgets/card_menu_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      category: EnumMenuItemCategory.bebida,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Caffe_Latte_cup.jpg/960px-Caffe_Latte_cup.jpg',
    ),
    MenuItem(
      name: 'Cappuccino',
      price: 28.0,
      category: EnumMenuItemCategory.bebida,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Caffe_Latte_cup.jpg/960px-Caffe_Latte_cup.jpg',
    ),
    MenuItem(
      name: 'Espresso',
      price: 25.0,
      category: EnumMenuItemCategory.bebida,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Caffe_Latte_cup.jpg/960px-Caffe_Latte_cup.jpg',
    ),
    MenuItem(
      name: 'Café Latte',
      price: 30.0,
      category: EnumMenuItemCategory.bebida,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Caffe_Latte_cup.jpg/960px-Caffe_Latte_cup.jpg',
    ),
    MenuItem(
      name: 'Cappuccino',
      price: 28.0,
      category: EnumMenuItemCategory.bebida,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Caffe_Latte_cup.jpg/960px-Caffe_Latte_cup.jpg',
    ),
    MenuItem(
      name: 'Espresso',
      price: 25.0,
      category: EnumMenuItemCategory.bebida,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Caffe_Latte_cup.jpg/960px-Caffe_Latte_cup.jpg',
    ),
    MenuItem(
      name: 'Café Latte',
      price: 30.0,
      category: EnumMenuItemCategory.bebida,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Caffe_Latte_cup.jpg/960px-Caffe_Latte_cup.jpg',
    ),
    MenuItem(
      name: 'Cappuccino',
      price: 28.0,
      category: EnumMenuItemCategory.bebida,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Caffe_Latte_cup.jpg/960px-Caffe_Latte_cup.jpg',
    ),
    MenuItem(
      name: 'Espresso',
      price: 25.0,
      category: EnumMenuItemCategory.bebida,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Caffe_Latte_cup.jpg/960px-Caffe_Latte_cup.jpg',
    ),
  ];

  // Alimentos
  final List<MenuItem> _alimentos = [
    MenuItem(
      name: 'Sandwich',
      price: 30.0,
      category: EnumMenuItemCategory.comida,
      imageUrl: 'https://lh4.googleusercontent.com/proxy/yGjLM7fUdWe58nbHLfkDeHifXPyNdvmN6SH7E_whSZkBs2HZBeFSFqMqW7-9tWhexjz-t150RYWS8nrzIWMq5_5tIsB-exiFvjVSvi3lJMICpwc_ToohHyoVt7paaXXrfHGpPb_klw',
    ),
    MenuItem(
      name: 'Cuernito',
      price: 28.0,
      category: EnumMenuItemCategory.comida,
      imageUrl: 'https://lh4.googleusercontent.com/proxy/yGjLM7fUdWe58nbHLfkDeHifXPyNdvmN6SH7E_whSZkBs2HZBeFSFqMqW7-9tWhexjz-t150RYWS8nrzIWMq5_5tIsB-exiFvjVSvi3lJMICpwc_ToohHyoVt7paaXXrfHGpPb_klw',
    ),
    MenuItem(
      name: 'Baguette',
      price: 25.0,
      category: EnumMenuItemCategory.comida,
      imageUrl: 'https://lh4.googleusercontent.com/proxy/yGjLM7fUdWe58nbHLfkDeHifXPyNdvmN6SH7E_whSZkBs2HZBeFSFqMqW7-9tWhexjz-t150RYWS8nrzIWMq5_5tIsB-exiFvjVSvi3lJMICpwc_ToohHyoVt7paaXXrfHGpPb_klw',
    ),
    MenuItem(
      name: 'Sandwich',
      price: 30.0,
      category: EnumMenuItemCategory.comida,
      imageUrl: 'https://lh4.googleusercontent.com/proxy/yGjLM7fUdWe58nbHLfkDeHifXPyNdvmN6SH7E_whSZkBs2HZBeFSFqMqW7-9tWhexjz-t150RYWS8nrzIWMq5_5tIsB-exiFvjVSvi3lJMICpwc_ToohHyoVt7paaXXrfHGpPb_klw',
    ),
    MenuItem(
      name: 'Cuernito',
      price: 28.0,
      category: EnumMenuItemCategory.comida,
      imageUrl: 'https://lh4.googleusercontent.com/proxy/yGjLM7fUdWe58nbHLfkDeHifXPyNdvmN6SH7E_whSZkBs2HZBeFSFqMqW7-9tWhexjz-t150RYWS8nrzIWMq5_5tIsB-exiFvjVSvi3lJMICpwc_ToohHyoVt7paaXXrfHGpPb_klw',
    ),
    MenuItem(
      name: 'Baguette',
      price: 25.0,
      category: EnumMenuItemCategory.comida,
      imageUrl: 'https://lh4.googleusercontent.com/proxy/yGjLM7fUdWe58nbHLfkDeHifXPyNdvmN6SH7E_whSZkBs2HZBeFSFqMqW7-9tWhexjz-t150RYWS8nrzIWMq5_5tIsB-exiFvjVSvi3lJMICpwc_ToohHyoVt7paaXXrfHGpPb_klw',
    ),
    MenuItem(
      name: 'Sandwich',
      price: 30.0,
      category: EnumMenuItemCategory.comida,
      imageUrl: 'https://lh4.googleusercontent.com/proxy/yGjLM7fUdWe58nbHLfkDeHifXPyNdvmN6SH7E_whSZkBs2HZBeFSFqMqW7-9tWhexjz-t150RYWS8nrzIWMq5_5tIsB-exiFvjVSvi3lJMICpwc_ToohHyoVt7paaXXrfHGpPb_klw',
    ),
    MenuItem(
      name: 'Cuernito',
      price: 28.0,
      category: EnumMenuItemCategory.comida,
      imageUrl: 'https://lh4.googleusercontent.com/proxy/yGjLM7fUdWe58nbHLfkDeHifXPyNdvmN6SH7E_whSZkBs2HZBeFSFqMqW7-9tWhexjz-t150RYWS8nrzIWMq5_5tIsB-exiFvjVSvi3lJMICpwc_ToohHyoVt7paaXXrfHGpPb_klw',
    ),
    MenuItem(
      name: 'Baguette',
      price: 25.0,
      category: EnumMenuItemCategory.comida,
      imageUrl: 'https://lh4.googleusercontent.com/proxy/yGjLM7fUdWe58nbHLfkDeHifXPyNdvmN6SH7E_whSZkBs2HZBeFSFqMqW7-9tWhexjz-t150RYWS8nrzIWMq5_5tIsB-exiFvjVSvi3lJMICpwc_ToohHyoVt7paaXXrfHGpPb_klw',
    ),
    MenuItem(
      name: 'Sandwich',
      price: 30.0,
      category: EnumMenuItemCategory.comida,
      imageUrl: 'https://lh4.googleusercontent.com/proxy/yGjLM7fUdWe58nbHLfkDeHifXPyNdvmN6SH7E_whSZkBs2HZBeFSFqMqW7-9tWhexjz-t150RYWS8nrzIWMq5_5tIsB-exiFvjVSvi3lJMICpwc_ToohHyoVt7paaXXrfHGpPb_klw',
    ),
    MenuItem(
      name: 'Cuernito',
      price: 28.0,
      category: EnumMenuItemCategory.comida,
      imageUrl: 'https://lh4.googleusercontent.com/proxy/yGjLM7fUdWe58nbHLfkDeHifXPyNdvmN6SH7E_whSZkBs2HZBeFSFqMqW7-9tWhexjz-t150RYWS8nrzIWMq5_5tIsB-exiFvjVSvi3lJMICpwc_ToohHyoVt7paaXXrfHGpPb_klw',
    ),
    MenuItem(
      name: 'Baguette',
      price: 25.0,
      category: EnumMenuItemCategory.comida,
      imageUrl: 'https://lh4.googleusercontent.com/proxy/yGjLM7fUdWe58nbHLfkDeHifXPyNdvmN6SH7E_whSZkBs2HZBeFSFqMqW7-9tWhexjz-t150RYWS8nrzIWMq5_5tIsB-exiFvjVSvi3lJMICpwc_ToohHyoVt7paaXXrfHGpPb_klw',
    ),
  ];

  final List<MenuItem> _menus = [
    MenuItem(
      name: 'Combo Desayuno',
      price: 75.0,
      category: EnumMenuItemCategory.menu,
      imageUrl: 'https://content.clara.es/medio/2024/10/16/desayunos-sin-pan-crep-frutos-rojos_a7503192_241016091932_1280x1280.webp',
    ),
    MenuItem(
      name: 'Lunch Express',
      price: 90.0,
      category: EnumMenuItemCategory.menu,
      imageUrl: 'https://content.clara.es/medio/2024/10/16/desayunos-sin-pan-crep-frutos-rojos_a7503192_241016091932_1280x1280.webp',
    ),
    MenuItem(
      name: 'Tarde Dulce',
      price: 65.0,
      category: EnumMenuItemCategory.menu,
      imageUrl: 'https://content.clara.es/medio/2024/10/16/desayunos-sin-pan-crep-frutos-rojos_a7503192_241016091932_1280x1280.webp',
    ),
    MenuItem(
      name: 'Combo Desayuno',
      price: 75.0,
      category: EnumMenuItemCategory.menu,
      imageUrl: 'https://content.clara.es/medio/2024/10/16/desayunos-sin-pan-crep-frutos-rojos_a7503192_241016091932_1280x1280.webp',
    ),
    MenuItem(
      name: 'Lunch Express',
      price: 90.0,
      category: EnumMenuItemCategory.menu,
      imageUrl: 'https://content.clara.es/medio/2024/10/16/desayunos-sin-pan-crep-frutos-rojos_a7503192_241016091932_1280x1280.webp',
    ),
    MenuItem(
      name: 'Tarde Dulce',
      price: 65.0,
      category: EnumMenuItemCategory.menu,
      imageUrl: 'https://content.clara.es/medio/2024/10/16/desayunos-sin-pan-crep-frutos-rojos_a7503192_241016091932_1280x1280.webp',
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
      : Row(
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
                child: FutureBuilder<List<MenuItem>>(
                  future: context.read<MenuItemProvider>().getMenuItems(), 
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final items = snapshot.data!;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return CardMenuCustom(item: item);
                      },
                    );
                  }
                )
                    // final item = _menus[i];
                    // final isFeatured = item.name == 'Especial del Día';
                    // return Container(
                    //   margin: const EdgeInsets.only(bottom: 12),
                    //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Text(
                    //     item.name,
                    //     style: TextStyle(
                    //       color: Colors.blue,
                    //       fontSize: isFeatured ? 18 : 16,
                    //       fontWeight: isFeatured ? FontWeight.bold : FontWeight.w500,
                    //     ),
                    //   ),
                    // );
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
                child: FutureBuilder<List<MenuItem>>(
                  future: context.read<MenuItemProvider>().getMenuItems(), 
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final items = snapshot.data!;
                    return GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1,
                            // SON grids independientes, scrolling vertical propio:
                            physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(4),
                        children: items.map((item) => CardMenuCustom(item: item)).toList(),
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
                child: FutureBuilder<List<MenuItem>>(
                  future: context.read<MenuItemProvider>().getMenuItems(), 
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final items = snapshot.data!;
                    return GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1,
                            // SON grids independientes, scrolling vertical propio:
                            physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(4),
                        children: items.map((item) => CardMenuCustom(item: item)).toList(),
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

