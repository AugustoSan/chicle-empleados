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

/// Lista de todos los elementos del drawer
const List<DrawerItem> drawerItems = [
  DrawerItem(icon: Icons.home,    title: 'Inicio',        route: '/home'),
  DrawerItem(icon: Icons.food_bank,    title: 'Menu',        route: '/menuItems'),
  DrawerItem(icon: Icons.settings,title: 'Configuración', route: '/settings'),
  DrawerItem(icon: Icons.person,  title: 'Perfil',       route: '/perfil'),
  DrawerItem(icon: Icons.help,    title: 'Ayuda',         route: '/help'),
];
