// import 'package:chicle_app_empleados/presentation/utils/route.dart';
// import 'package:flutter/material.dart';

// import '../presentation.dart';

// class ShellApp extends StatefulWidget {
//   const ShellApp({super.key});
//   @override
//   State<ShellApp> createState() => _ShellAppState();
// }

// class _ShellAppState extends State<ShellApp> {
//   final _shellNavigatorKey = GlobalKey<NavigatorState>();
//   int _selectedIndex = 0;
//   int _selectedBottomIndex = 0;

//   void onTap(int index) {
//     setState(() {
//       if(index != _selectedIndex) {
//         _selectedIndex = index;
//         _shellNavigatorKey.currentState!.pushNamed(drawerMenuItems[index].route);
//       }
//     });
//   }

//   void onTapBottom(int index) {
//     print('Route: ${index}');
//     setState(() {
//       if(index != _selectedBottomIndex) {
//         _selectedBottomIndex = index;
//         _shellNavigatorKey.currentState!.pushNamed(menuBottomItems[index].route);
//       }
//     });
//   }

//   @override  Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBarCustom(
//         currentRoute: drawerMenuItems[_selectedIndex].route, 
//         onSettings: () => _shellNavigatorKey.currentState!.pushNamed(DrawerMenuItems.settings.route),
//         onHelp: () => _shellNavigatorKey.currentState!.pushNamed(DrawerMenuItems.help.route),
//       ),
//       // drawer: DrawerCustom(navigatorKey: _shellNavigatorKey),
//       // floatingActionButton: _buildFab(),
//       body: Navigator(
//         key: _shellNavigatorKey,
//         initialRoute: '/',
//         onGenerateRoute: (settings) {
//           print('Route: ${settings.name}');
//           Widget page = RouteUtils().getPage(settings.name!);
//           return MaterialPageRoute(builder: (_) => page, settings: settings);
//         },
//       ),
//       bottomNavigationBar: MenuBottomCustom(
//             currentIndex: _selectedBottomIndex,
//             onTap: onTapBottom,
//             shellNavigatorKey: _shellNavigatorKey,
//           ),
//     );
//   }
// }
