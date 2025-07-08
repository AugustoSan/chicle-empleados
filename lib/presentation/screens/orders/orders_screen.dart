import 'package:flutter/material.dart';
import './orders_portrait.dart';
// import './orders_landscape.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    print('orientation: $orientation');
    // return orientation == Orientation.portrait
    //     ? OrdersPortrait()
    //     : OrdersLandscape();
    return const OrdersPortrait();
  }
}