import 'package:flutter/material.dart';

import '../presentation.dart';

/// BottomNavigationBar con dos pestañas: Bebidas y Menús
class MenuBottomCustom extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final GlobalKey<NavigatorState> shellNavigatorKey;

  const MenuBottomCustom({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.shellNavigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showSelected = currentIndex >= 0 && currentIndex < menuBottomItems.length;
    return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
        child: NavigationBar(
          height: 65,
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          animationDuration: const Duration(milliseconds: 500),
          selectedIndex: showSelected ? currentIndex : 0,
          elevation: 4,
          onDestinationSelected: onTap,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle;
            } else {
              return Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle;
            } 
          }),
          indicatorColor: showSelected ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor : null,
          destinations: menuBottomItems.map(
            (item) => 
            NavigationDestination(
              icon: Icon(item.icon, color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor),
              selectedIcon: Icon(item.icon, color: showSelected ? Colors.white : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor, size: 24),
              label: item.title,
            )
          ).toList(),
        ),
      );
  } 
}
