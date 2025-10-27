import 'package:chicle_app_empleados/presentation/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

/// Pantalla que muestra dos secciones: Bebidas y Menús.
/// Usa un BottomNavigationBar para alternar entre ellas.
class ProductsPortrait extends StatefulWidget {
  const ProductsPortrait({Key? key}) : super(key: key);

  @override
  State<ProductsPortrait> createState() => _ProductsPortraitState();
}

class _ProductsPortraitState extends State<ProductsPortrait> {
  // List<Product> menuList = [];
  // List<Product> bebidasList = [];
  // List<Product> alimentosList = [];
  // List<Product> extraList = [];
  List<Category> categories = [];


  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    // menuList.clear();
    // bebidasList.clear();
    // alimentosList.clear();
    // extraList.clear();
    categories.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }

  Future<void> _init() async {
    final provider = context.read<CategoryProvider>();
    await provider.loadAll();

    if (!mounted) return;

    final items = provider.allItems;

    setState(() {
      // menuList.clear();
      // bebidasList.clear();
      // alimentosList.clear();
      // extraList.clear();
      // menuList = items.where((item) => item.category == EnumProductCategory.menu).toList();
      // bebidasList = items.where((item) => item.category == EnumProductCategory.bebida).toList();
      // alimentosList = items.where((item) => item.category == EnumProductCategory.alimento).toList();
      // extraList = items.where((item) => item.category == EnumProductCategory.extra).toList();
      categories.clear();
      categories = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(categories.isEmpty) {
      return const Center(child: Text('Sin datos'));
    }
    
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // MenuCarousel(
        //   items: menuList,
        //   title: 'Menús',
        // ),

        // MenuCarousel(
        //   items: bebidasList,
        //   title: 'Bebidas',
        // ),

        // MenuCarousel(
        //   items: alimentosList,
        //   title: 'Alimentos',
        // ),

        // MenuCarousel(
        //   items: extraList,
        //   title: 'Extras',
        // ),
        ...categories.map((category) => MenuCarousel(items: category.items, title: category.name))
      ],
    );
  }
}

