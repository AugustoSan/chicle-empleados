import 'package:flutter/material.dart';

/// Representa un elemento del menú lateral.
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
    icon: Icons.food_bank,
    title: 'Menu',
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
    route: '/',
  );
  static const DrawerItem help = DrawerItem(
    icon: Icons.help,
    title: 'Ayuda',
    route: '/',
  );
  static const DrawerItem logout = DrawerItem(
    icon: Icons.logout,
    title: 'Cerrar Sesión',
    route: '/logout',
  );
}

const List<DrawerItem> drawerMenuItems = [
  DrawerMenuItems.settings,
  DrawerMenuItems.logout,
];

/// Lista de todos los elementos del drawer
const List<DrawerItem> menuBottomItems = [
  DrawerMenuItems.home,
  DrawerMenuItems.menu,
  DrawerMenuItems.order,
];
