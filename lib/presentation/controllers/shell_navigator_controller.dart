import 'package:flutter/material.dart';
import 'package:chicle_app_empleados/presentation/widgets/drawer_items.dart';

class ShellNavigatorController extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // indice del menu desplegable
  int _selectedPopupMenuIndex = 0;
  int get selectedPopupMenuIndex => _selectedPopupMenuIndex;

  // indice del menu bottom
  int _selectedBottomMenuIndex = 0;
  int get selectedBottomMenuIndex => _selectedBottomMenuIndex;

  String _currentRoute = '/';
  String get currentRoute => _currentRoute;
  
  void navigatePopupMenu(String route) {
    if (route == _currentRoute) return;
    switch (route) {
      case '/settings':
        _currentRoute = route;
        _selectedBottomMenuIndex = -1;
        navigatorKey.currentState!.pushNamed(DrawerMenuItems.settings.route);
        break;
      case '/help':
        _currentRoute = route;
        _selectedBottomMenuIndex = -1;
        navigatorKey.currentState!.pushNamed(DrawerMenuItems.help.route);
        break;
    }
    notifyListeners();
  }

  void navigateBottomMenu(int index) {
    if (index == _selectedBottomMenuIndex) return;
    if(index >= 0 && index < menuBottomItems.length) {
      print('------------------------------------------------------------');
      print('desde: ${_currentRoute}    ---->   hacia: ${menuBottomItems[index].route}');
      print('------------------------------------------------------------');
      
      _currentRoute = menuBottomItems[index].route;
      _selectedBottomMenuIndex = index;

      switch (menuBottomItems[index].route) {
        case '/home':
          navigatorKey.currentState!.pushNamed(DrawerMenuItems.home.route);
          break;
        case '/menuItems':
          navigatorKey.currentState!.pushNamed(DrawerMenuItems.menu.route);
          break;
        case '/orders':
          navigatorKey.currentState!.pushNamed(DrawerMenuItems.order.route);
          break;
        default:
          print('entro en default');
          navigatorKey.currentState!.pushNamed(DrawerMenuItems.home.route);
          break;
      }
    }
    notifyListeners();
  }
}
