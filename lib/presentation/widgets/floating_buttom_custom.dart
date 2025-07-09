import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation.dart';

import '../screens/modules/add_menu.dart';
import '../screens/home/add_sale.dart';

class FloatingButtomCustom extends StatelessWidget {
  const FloatingButtomCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorKey = context.watch<ShellNavigatorController>();
    // bool showFloatingButton = navigatorKey.selectedBottomMenuIndex >= 0 && navigatorKey.selectedBottomMenuIndex < menuBottomItems.length;
    bool showFloatingButton = navigatorKey.currentRoute == DrawerMenuItems.home.route || navigatorKey.currentRoute == DrawerMenuItems.menu.route;
    return showFloatingButton ? FloatingActionButton(
      onPressed: (){
        print('Floating button pressed ${navigatorKey.currentRoute}');
        if(navigatorKey.currentRoute == DrawerMenuItems.menu.route){
          navigatorKey.navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (ctx) => AddMenuItemController(ctx.read<MenuItemProvider>()), 
                child: const AddMenuScreen()
              )
            )
          );
        }
        if(navigatorKey.currentRoute == DrawerMenuItems.home.route){
          navigatorKey.navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (ctx) => AddSaleController(getIt<SalesRepository>(), getIt<UserProvider>()), 
                child: const AddSaleScreen()
              )
            )
          );
        }
      },
      child: Icon(Icons.add),
    ) : const SizedBox.shrink();
  }
}