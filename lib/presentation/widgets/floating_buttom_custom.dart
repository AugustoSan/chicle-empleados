// import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation.dart';

import '../screens/modules/add_menu.dart';
// import '../screens/home/add_sale.dart';

class FloatingButtomCustom extends StatelessWidget {
  const FloatingButtomCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final shell = context.watch<ShellNavigatorController>();
    // bool showFloatingButton = shell.selectedBottomMenuIndex >= 0 && shell.selectedBottomMenuIndex < menuBottomItems.length;
    bool showFloatingButton = shell.secondRoute.isNotEmpty;
    return showFloatingButton ? FloatingActionButton(
      onPressed: (){
        shell.setSecondRoute('');
        shell.navigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (ctx) => AddMenuItemController(ctx.read<MenuItemProvider>()), 
              child: const AddMenuScreen()
            )
          )
        );
      },
      child: Icon(Icons.add),
    ) : const SizedBox.shrink();
  }
}