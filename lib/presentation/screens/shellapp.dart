import 'package:chicle_app_empleados/presentation/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation.dart';

class ShellApp extends StatelessWidget {
  const ShellApp({super.key});

  @override  Widget build(BuildContext context) {
    final navigatorKey = context.watch<ShellNavigatorController>();
    // final selectedIndex = navigatorKey.selectedPopupMenuIndex;
    final selectedBottomIndex = navigatorKey.selectedBottomMenuIndex;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarCustom(
        currentRoute: navigatorKey.currentRoute, 
        onTap: navigatorKey.navigatePopupMenu,
      ),
      body: Navigator(
        key: navigatorKey.navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          Widget page = RouteUtils().getPage(settings.name!);
          return MaterialPageRoute(builder: (_) => page, settings: settings);
        },
      ),
      bottomNavigationBar: MenuBottomCustom(
            currentIndex: selectedBottomIndex,
            onTap: navigatorKey.navigateBottomMenu,
            shellNavigatorKey: navigatorKey.navigatorKey,
          ),
    );
  }
}
