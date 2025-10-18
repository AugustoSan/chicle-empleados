import 'package:flutter/material.dart';
import '../presentation.dart';

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

  String _secondRoute = '';
  String get secondRoute => _secondRoute;

  void initialize() {
    _selectedPopupMenuIndex = 0;
    _selectedBottomMenuIndex = 0;
    _currentRoute = '/';
    _secondRoute = '';
    notifyListeners();
  }

  void setSecondRoute(String value) {
    _secondRoute = value; 
    notifyListeners();
  }
  
  void navigatePopupMenu(String route) {
    setSecondRoute('');
    if (route == _currentRoute) return;
    print('------------------------------------------------------------');
    print('desde: ${_currentRoute}    ---->   hacia: ${route}');
    print('------------------------------------------------------------');
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
    setSecondRoute('');
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
          setSecondRoute('/addMenu');
          navigatorKey.currentState!.pushNamed(DrawerMenuItems.menu.route);
          break;
        case '/orders':
          navigatorKey.currentState!.pushNamed(DrawerMenuItems.order.route);
          break;
        case '/users':
          setSecondRoute('/addUser');
          navigatorKey.currentState!.pushNamed(DrawerMenuItems.users.route);
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
