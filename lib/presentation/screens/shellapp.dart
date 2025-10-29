import 'package:chicle_app_empleados/domain/urls/urls.dart';
import 'package:chicle_app_empleados/presentation/screens/home/home.dart';
import 'package:chicle_app_empleados/presentation/screens/orders/orders.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import '../presentation.dart';

class ShellApp extends StatefulWidget {
  const ShellApp({super.key});

  @override
  State<ShellApp> createState() => _ShellAppState();
}

class _ShellAppState extends State<ShellApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0; // Para almacenar el índice de la pestaña actual

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: menuTabsItems.length, vsync: this); // Ejemplo: 3 pestañas
    _tabController.addListener(_handleTabSelection); // Agrega el listener

    // Inicializa el índice actual
    _currentIndex = _tabController.index;
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      // Este bloque se ejecuta cuando la animación de la pestaña está en progreso.
      // Puedes usar _tabController.previousIndex si necesitas el índice anterior.
    }
    setState(() {
      _currentIndex = _tabController.index; // Actualiza el índice actual cuando la pestaña cambia
    });
    print("Tab actual: $_currentIndex");
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection); // Remueve el listener para evitar fugas de memoria
    _tabController.dispose();
    super.dispose();
  }

  // Función para determinar si el FAB debe ser visible
  bool _shouldShowFab() {
    // Por ejemplo, solo queremos mostrar el FAB en la primera pestaña (índice 0)
    return _currentIndex == menuTabsItems.indexWhere((item) => item == DrawerProducts.products);
    // O si quieres mostrarlo en la pestaña 0 y 1, pero no en la 2:
    // return _currentIndex == 0 || _currentIndex == 1;
  }

  @override  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom( 
            tabController: _tabController,
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              HomeScreen(),
              ProductScreen(),
              OrdersScreen(),
            ],
          ),
          floatingActionButton: _shouldShowFab() 
            ? FloatingActionButton(onPressed: () => mostrarQrImageDialog(context, apiUrl + "carta.html"), child: const Icon(Icons.qr_code))
            : null,
      );
  }
}
