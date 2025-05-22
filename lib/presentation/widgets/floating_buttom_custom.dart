import 'package:chicle_app_empleados/presentation/screens/modules/add_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation.dart';

class FloatingButtomCustom extends StatelessWidget {
  const FloatingButtomCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorKey = context.watch<ShellNavigatorController>();
    bool showFloatingButton = navigatorKey.selectedBottomMenuIndex >= 0 && navigatorKey.selectedBottomMenuIndex < menuBottomItems.length;
    return showFloatingButton ? FloatingActionButton(
      onPressed: (){
        print('Floating button pressed ${navigatorKey.currentRoute}');
        if(navigatorKey.currentRoute == DrawerMenuItems.menu.route){
          navigatorKey.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => AddMenuScreen()));
        }
      },
      child: Icon(Icons.add),
    ) : const SizedBox.shrink();
  }
}