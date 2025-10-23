import 'package:flutter/material.dart';
import 'products.dart';

/// Pantalla que muestra dos secciones: Bebidas y Menús.
/// Usa un BottomNavigationBar para alternar entre ellas.
class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final orientation = MediaQuery.of(context).orientation;
    print('orientation: $orientation');

    // return orientation == Orientation.portrait
    //     ? ProductsPortrait()
    //     : ProductsLandscape();
    return const ProductsPortrait();
  }
}

