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

class DrawerItems {
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
  static const DrawerItem settings = DrawerItem(
    icon: Icons.settings,
    title: 'Configuración',
    route: '/settings',
  );
  static const DrawerItem profile = DrawerItem(
    icon: Icons.person,
    title: 'Perfil',
    route: '/perfil',
  );
  static const DrawerItem help = DrawerItem(
    icon: Icons.help,
    title: 'Ayuda',
    route: '/help',
  );
}

/// Lista de todos los elementos del drawer
const List<DrawerItem> drawerItems = [
  DrawerItem(icon: Icons.home,    title: 'Inicio',        route: '/home'),
  DrawerItem(icon: Icons.food_bank,    title: 'Menu',        route: '/menuItems'),
  DrawerItem(icon: Icons.settings,title: 'Configuración', route: '/settings'),
  DrawerItem(icon: Icons.person,  title: 'Perfil',       route: '/perfil'),
  DrawerItem(icon: Icons.help,    title: 'Ayuda',         route: '/help'),
];
