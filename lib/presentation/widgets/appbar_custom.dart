import 'package:chicle_app_empleados/presentation/providers/auth_provider.dart';
import 'package:chicle_app_empleados/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/providers/business_provider.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget{
  final String currentRoute;
  final VoidCallback onSettings;
  final VoidCallback onHelp;
  const AppBarCustom({super.key, required this.currentRoute, required this.onSettings, required this.onHelp});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext ctx) {
    final business = ctx.watch<BusinessProvider>().business;
    String title = business?.name ?? 'Chicle';
    // final canGoBack = Navigator.canPop(ctx);
    return AppBar(
      // leading: canGoBack
      //     ? IconButton(
      //         icon: const Icon(Icons.arrow_back),
      //         onPressed: () => Navigator.pop(ctx),
      //       )
      //     : null,
      title: Text(title, style: const TextStyle(fontSize: 24)),
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case '/settings':
                onSettings();
                break;
              case '/logout':
                ctx.read<AuthProvider>().logout();
                break;
              case '/help':
                onHelp();
                break;
            }
          },
          itemBuilder: (ctx) => drawerMenuItems.map((item) => PopupMenuItem(value: item.route, child: Text(item.title))).toList(),
        ),
      ],
    );
  }
}
