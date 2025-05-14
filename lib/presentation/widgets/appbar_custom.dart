import 'package:chicle_app_empleados/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/providers/business_provider.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget{
  final String currentRoute;
  final VoidCallback onSettings;
  const AppBarCustom({super.key, required this.currentRoute, required this.onSettings});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext ctx) {
    final business = ctx.watch<BusinessProvider>().business;
    String title = business?.name ?? 'Chicle';
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
        PopupMenuButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onSelected: (value) {
            switch (value) {
              case 'settings':
                onSettings();
                break;
              case 'logout':
                ctx.read<AuthProvider>().logout();
                break;
            }
          },
          itemBuilder: (ctx) => [
            const PopupMenuItem(value: 'settings', child: Text('Configuración')),
            const PopupMenuItem(value: 'logout', child: Text('Cerrar Sesión')),
          ],
        ),
      ],
    );
  }
}
