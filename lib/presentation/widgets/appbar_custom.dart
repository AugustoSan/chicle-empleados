import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget{
  // final String currentRoute;
  // final Function(String) onTap;
  final TabController tabController;
  const AppBarCustom({super.key,required this.tabController});

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight + kToolbarHeight + 10);

  @override
  Widget build(BuildContext ctx) {
    final business = ctx.watch<BusinessProvider>().business;
    String title = business?.name ?? 'Chicle';
    return AppBar(
      title: Text(title, style: const TextStyle(fontSize: 24)),
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case '/settings':
                Navigator.push(ctx, RouteUtils().getRouteSettings());
                break;
              case '/generate-qr':
                Navigator.push(ctx, RouteUtils().getQrSettings());
                break;
              case '/logout':
              default:
                ctx.read<AuthProvider>().logout();
                break;
            }
          },
          itemBuilder: (ctx) => popupMenuItems.map((item) => PopupMenuItem(value: item.route, child: Text(item.title))).toList(),
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        indicatorColor: Theme.of(ctx).primaryColor,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Theme.of(ctx).primaryColorDark,
        tabs: 
        menuTabsItems.map(
          (item) => 
            Tab(
              icon: Icon(item.icon), 
              text: item.title
            )
        ).toList(),
      ),
    );
  }
}
