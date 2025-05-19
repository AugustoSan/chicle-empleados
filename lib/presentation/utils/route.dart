import 'package:flutter/material.dart';

import 'package:chicle_app_empleados/presentation/screens/home/home_screen.dart';
import 'package:chicle_app_empleados/presentation/screens/modules/menuitems_list_screen.dart';
import 'package:chicle_app_empleados/presentation/screens/settings/settings_screen.dart' show SettingsScreen;

class RouteUtils {
  Widget getPage(String route) {
    print('route: $route');
    Widget page;
    switch (route) {
      case '/home':
        page = const HomeScreen();
        break;
      case '/menuItems':
        page = const MenuItemsListScreen();
        break;
      case '/orders':
        // page = const OrdersScreen();
        page = const HomeScreen();
        break;
      case '/settings':
        page = const SettingsScreen();
        break;
      case '/profile':
        page = const HomeScreen();
        break;
      case '/help':
        page = const HomeScreen();
        break;
      case '/': 
      default:
        page = const HomeScreen();
    }
    return page;
  }
}