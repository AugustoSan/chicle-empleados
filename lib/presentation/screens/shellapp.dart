import 'package:flutter/material.dart';

import '../presentation.dart';
import './../screens/modules/menuitems_list_screen.dart';
import './../screens/home/home_screen.dart';
import './../screens/settings/settings_screen.dart';

class ShellApp extends StatefulWidget {
  const ShellApp({super.key});
  @override
  State<ShellApp> createState() => _ShellAppState();
}

class _ShellAppState extends State<ShellApp> {
  final _shellNavigatorKey = GlobalKey<NavigatorState>();
  // String _currentRoute = '/home';
  int _selectedIndex = 0;

  void _onTabTapped(int idx) => setState(() => _selectedIndex = idx);
  

  @override
  Widget build(BuildContext context) {
    final titles = ['Bebidas', 'Menús', 'Órdenes'];
    return Scaffold(
      appBar: AppBarCustom(currentRoute: titles[_selectedIndex]),
      // drawer: DrawerCustom(navigatorKey: _shellNavigatorKey),
      // floatingActionButton: _buildFab(),
      body: Navigator(
        key: _shellNavigatorKey,
        initialRoute: '/home',
        onGenerateRoute: (settings) {
          Widget page;
          switch (settings.name) {
            case '/settings':
              page = const SettingsScreen();
              break;
            case '/home':
              page = const HomeScreen();
              break;
            case '/menuItems':
              page = MenuItemsListScreen();
              break;
            default:
              page = const HomeScreen();
          }
          return MaterialPageRoute(builder: (_) => page, settings: settings);
        },
      ),
      bottomNavigationBar: MenuBottomCustom(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  // Widget? _buildFab() {
  //   // Si estamos en settings, no mostramos nada
  //   if (_currentRoute == '/settings' || _currentRoute == '/home' || _currentRoute == '/' || _currentRoute == '/help') return null;

  //   // Definimos ruta de destino y icono según ruta actual
  //   String targetRoute;
  //   IconData icon;
  //   String tooltip;

  //   print(_currentRoute);

  //   switch (_currentRoute) {
  //     case '/menuItems':
  //       targetRoute = '/newMenuItem';
  //       icon = Icons.add_card;
  //       tooltip = 'Agregar nuevo menu';
  //       break;
  //     case '/orders':
  //       targetRoute = '/newOrder';
  //       icon = Icons.add_shopping_cart;
  //       tooltip = 'Agregar nueva orden';
  //       break;
  //     case '/home':
  //     default:
  //       targetRoute = '/newSomething';
  //       icon = Icons.add;
  //       tooltip = 'Agregar nuevo';
  //   }

  //   return FloatingActionButton(
  //     tooltip: tooltip,
  //     child: Icon(icon),
  //     onPressed: () {
  //       // Si el drawer estaba abierto, lo cerramos primero
  //       _shellNavigatorKey.currentState?.pop();
  //       // Luego empujamos la ruta del formulario correspondiente
  //       _shellNavigatorKey.currentState?.pushNamed(targetRoute);
  //     },
  //   );
  // }
}
