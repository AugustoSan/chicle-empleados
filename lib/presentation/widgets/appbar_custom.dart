import 'package:chicle_app_empleados/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/providers/business_provider.dart';

class AppBarCustom extends StatefulWidget implements PreferredSizeWidget{
  final String currentRoute;
  AppBarCustom({super.key, required this.currentRoute});
  @override
  State<AppBarCustom> createState() => _AppBarCustomState(currentRoute: currentRoute);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarCustomState extends State<AppBarCustom>{
  final String currentRoute;
  _AppBarCustomState({required this.currentRoute});
  @override
  Widget build(BuildContext ctx) {
    final business = ctx.watch<BusinessProvider>().business;
    print('name: ${business?.name}');
    String title = (currentRoute == '/home')
      ? (business?.name ?? 'Chicle')
      : _mapRouteToTitle(currentRoute);
    return AppBar(
      title: Text(title, style: const TextStyle(fontSize: 24, color: Colors.white)),
      backgroundColor: Theme.of(ctx).primaryColor,
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: _logout,
        ),
      ],
    );
  }

  String _mapRouteToTitle(String route) {
    switch (route) {
      case '/settings':   return 'Configuración';
      case '/menuItems':  return 'Productos';
      case '/orders':     return 'Órdenes';
      case '/perfil':     return 'Perfil';
      case '/help':       return 'Ayuda';
      default:            return 'Chicle';
    }
  }

  Future<void> _logout() async {
    final auth = context.read<AuthProvider>();
    await auth.logout();
  }
}
