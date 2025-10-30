// import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/presentation/screens/settings/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../screens/settings/settings.dart';
import '../screens/home/home.dart';
import '../screens/orders/orders.dart';
import '../screens/users/add_users.dart';

class DrawerItem {
  final IconData icon;
  final String title;
  final String route;

  const DrawerItem({
    required this.icon,
    required this.title,
    required this.route,
  });
}

class DrawerProducts {
  static const DrawerItem home = DrawerItem(
    icon: Icons.home,
    title: 'Inicio',
    route: '/home',
  );
  static const DrawerItem products = DrawerItem(
    icon: Icons.fastfood,
    title: 'Carta',
    route: '/products',
  );
  static const DrawerItem order = DrawerItem(
    icon: Icons.assignment,
    title: 'Ordenes',
    route: '/orders',
  );
  static const DrawerItem settings = DrawerItem(
    icon: Icons.settings,
    title: 'Configuración',
    route: '/settings',
  );
  static const DrawerItem profile = DrawerItem(
    icon: Icons.person,
    title: 'Perfil',
    route: '/profile',
  );
  static const DrawerItem help = DrawerItem(
    icon: Icons.help,
    title: 'Ayuda',
    route: '/help',
  );
  static const DrawerItem users = DrawerItem(
    icon: Icons.people,
    title: 'Usuarios',
    route: '/users',
  );
  static const DrawerItem acercaDe = DrawerItem(
    icon: Icons.info,
    title: 'Acerca de',
    route: '/acercaDe',
  );
  static const DrawerItem consultarQr = DrawerItem(
    icon: Icons.info,
    title: 'Consultar QR',
    route: '/generate-qr',
  );
  static const DrawerItem politicaPriv = DrawerItem(
    icon: Icons.privacy_tip,
    title: 'Política de privacidad',
    route: '/poliPriv',
  );
  static const DrawerItem companySettings = DrawerItem(
    icon: Icons.business,
    title: 'Negocio',
    route: '/companySettings',
  );
  static const DrawerItem logout = DrawerItem(
    icon: Icons.logout,
    title: 'Cerrar Sesión',
    route: '/logout',
  );
}

// Lista de todos los elementos del nav
const List<DrawerItem> navMenuItems = [
  DrawerProducts.home,
  DrawerProducts.products,
  DrawerProducts.order,
  DrawerProducts.settings,
  DrawerProducts.profile,
  DrawerProducts.users,
  DrawerProducts.help,
  DrawerProducts.logout,
];

/// Lista de todos los elementos del drawer
const List<DrawerItem> popupMenuItems = [
  DrawerProducts.settings,
  // DrawerProducts.consultarQr,
  DrawerProducts.logout,
];

/// Lista de todos los elementos del bottom
const List<DrawerItem> menuTabsItems = [
  DrawerProducts.home,
  DrawerProducts.products,
  DrawerProducts.order,
];


class RouteUtils {
  Widget getPage(String route) {
    print('route: $route');
    Widget page;
    switch (route) {
      case '/home':
        page = const HomeScreen();
        break;
      case '/menuItems':
        page = const ProductScreen();
        break;
      case '/orders':
        // page = const OrdersScreen();
        page = const OrdersScreen();
        break;
      case '/settings':
        page = const SettingsScreen();
        break;
      case '/users':
        page = const UsersScreen();
        break;
      case '/profile':
        page = const ProfileScreen();
        break;
      case '/help':
        page = const HomeScreen();
        break;
      case '/': 
      default:
        page = const HomeScreen();
    }
    return page;
  }

  // Route getRouteAddProduct() {
  //   return MaterialPageRoute(
  //     builder: (context) => ChangeNotifierProvider(
  //       create: (ctx) => AddProductController(ctx.read<ProductProvider>()), 
  //       child: const AddProductScreen()
  //     )
  //   );
  // }

  Route getRouteAddUser() {
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (ctx) => AddUserController(ctx.read<UserProvider>()), 
        child: const AddUserScreen()
      )
    );
  }

  // Route getRouteUpdateProduct(Product item) {
  //   return MaterialPageRoute(
  //     builder: (context) => ChangeNotifierProvider(
  //       create: (ctx) => UpdateProductController(ctx.read<ProductProvider>(), item),
  //       child: const UpdateProductScreen()
  //     )
  //   );
  // }

  Route getRouteSettings() {
    return MaterialPageRoute(
      builder: (context) => const SettingsScreen()
    );
  }

  Route getQrSettings() {
    return MaterialPageRoute(
      builder: (context) => const QrScreen()
    );
  }


  Route getRouteSettingsUsers() {
    return MaterialPageRoute(
      builder: (context) => const UsersScreen()
    );
  }

  Route getRouteSettingsProfile() {
    return MaterialPageRoute(
      builder: (context) => const ProfileScreen()
    );
  }

  Route getRouteSettingsCompany() {
    return MaterialPageRoute(
      builder: (context) => const CompanyScreen()
    );
  }

  Route getRouteSettingsAcercaDe() {
    return MaterialPageRoute(
      builder: (context) => AcercaDeScreen()
    );
  }

}