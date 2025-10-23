// import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../presentation.dart';

class FloatingButtomCustom extends StatelessWidget {
  final Route route;
  const FloatingButtomCustom({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    // final shell = context.watch<ShellNavigatorController>();
    // bool showFloatingButton = shell.selectedBottomMenuIndex >= 0 && shell.selectedBottomMenuIndex < menuBottomItems.length;
    // bool showFloatingButton = shell.secondRoute.isNotEmpty;
    return FloatingActionButton(
      onPressed: (){
        // if(shell.secondRoute == '/addMenu') {
          // shell.navigatorKey.currentState!.push(
          //   MaterialPageRoute(
          //     builder: (context) => ChangeNotifierProvider(
          //       create: (ctx) => AddProductController(ctx.read<ProductProvider>()), 
          //       child: const AddProductScreen()
          //     )
          //   )
          // );
          Navigator.push(context, route);
          // shell.setSecondRoute('');
        // }
      },
      child: Icon(Icons.add),
    );
  }
}