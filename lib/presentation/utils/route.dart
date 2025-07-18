import 'package:flutter/material.dart';


import '../screens/settings/settings.dart';
import '../screens/home/home.dart';
import '../screens/modules/modules.dart';
import '../screens/orders/orders.dart';

class DrawerItem {
  final IconData icon;
  final String title;
  final String route;

  const DrawerItem({
    required this.icon,
    required this.title,
    required this.route,
  });
}

class DrawerMenuItems {
  static const DrawerItem home = DrawerItem(
    icon: Icons.home,
    title: 'Inicio',
    route: '/home',
  );
  static const DrawerItem menu = DrawerItem(
    icon: Icons.fastfood,
    title: 'Carta',
    route: '/menuItems',
  );
  static const DrawerItem order = DrawerItem(
    icon: Icons.assignment,
    title: 'Ordenes',
    route: '/orders',
  );
  static const DrawerItem settings = DrawerItem(
    icon: Icons.settings,
    title: 'Configuración',
    route: '/settings',
  );
  static const DrawerItem profile = DrawerItem(
    icon: Icons.person,
    title: 'Perfil',
    route: '/profile',
  );
  static const DrawerItem help = DrawerItem(
    icon: Icons.help,
    title: 'Ayuda',
    route: '/help',
  );
  static const DrawerItem users = DrawerItem(
    icon: Icons.people,
    title: 'Usuarios',
    route: '/users',
  );
  static const DrawerItem acercaDe = DrawerItem(
    icon: Icons.info,
    title: 'Acerca de',
    route: '/acercaDe',
  );
  static const DrawerItem companySettings = DrawerItem(
    icon: Icons.business,
    title: 'Negocio',
    route: '/companySettings',
  );
  static const DrawerItem logout = DrawerItem(
    icon: Icons.logout,
    title: 'Cerrar Sesión',
    route: '/logout',
  );
}

// Lista de todos los elementos del nav
const List<DrawerItem> navMenuItems = [
  DrawerMenuItems.home,
  DrawerMenuItems.menu,
  DrawerMenuItems.order,
  DrawerMenuItems.settings,
  DrawerMenuItems.profile,
  DrawerMenuItems.users,
  DrawerMenuItems.help,
  DrawerMenuItems.logout,
];

/// Lista de todos los elementos del drawer
const List<DrawerItem> popupMenuItems = [
  DrawerMenuItems.settings,
  DrawerMenuItems.logout,
];

/// Lista de todos los elementos del bottom
const List<DrawerItem> menuBottomItems = [
  DrawerMenuItems.home,
  DrawerMenuItems.menu,
  DrawerMenuItems.order,
];


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
        page = const OrdersScreen();
        break;
      case '/settings':
        page = const SettingsScreen();
        break;
      case '/users':
        page = const UsersScreen();
        break;
      case '/profile':
        page = const ProfileScreen();
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