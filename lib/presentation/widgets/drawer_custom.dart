import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/providers/business_provider.dart';
import 'drawer_items.dart';

class DrawerCustom extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const DrawerCustom({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext ctx) {
    final business = ctx.watch<BusinessProvider>().business;
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(ctx).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Text(
                business?.name ?? 'Sin Nombre',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ...menuBottomItems.map((item) => ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: () {
              Navigator.of(ctx).pop(); 
              navigatorKey.currentState!.pushNamed(item.route);
            },
          )),
          ],
        ),
      );
  }
}
