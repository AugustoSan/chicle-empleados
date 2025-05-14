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
  int _selectedIndex = 0;

  void _onTabTapped(int idx) => setState(() => _selectedIndex = idx);
  

  @override
  Widget build(BuildContext context) {
    final titles = ['Bebidas', 'Menús', 'Órdenes'];
    return Scaffold(
      appBar: AppBarCustom(currentRoute: titles[_selectedIndex], onSettings: () => _shellNavigatorKey.currentState!.pushNamed(DrawerItems.settings.route)),
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
            case '/': 
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
}
