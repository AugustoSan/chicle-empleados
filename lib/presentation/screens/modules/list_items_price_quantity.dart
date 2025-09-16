import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItemsPriceQuantity extends StatefulWidget {
  final Map<MenuItem,SaleItemMenu> saleItems;
  const ListItemsPriceQuantity({Key? key, required this.saleItems}) : super(key: key);

  @override
  _ListItemsPriceQuantityState createState() => _ListItemsPriceQuantityState();
}

class _ListItemsPriceQuantityState extends State<ListItemsPriceQuantity> {
  final List<MenuItem> _listMenuItems = [];
  final Map<MenuItem,SaleItemMenu> _saleItems = {};
  

  @override
  void initState() {
    super.initState();
    context.read<MenuItemProvider>().loadAll();
    final menuItems = context.read<MenuItemProvider>().allItems;
    _listMenuItems.addAll(menuItems);
    for (var item in menuItems) {
      _saleItems[item] = widget.saleItems[item] ?? SaleItemMenu(menuItem: item, quantity: 0, specialIndications: '');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      final menuItems = context.watch<MenuItemProvider>().allItems;
      if (_listMenuItems.isEmpty && menuItems.isNotEmpty) {
        _listMenuItems.addAll(menuItems);
        for (var item in menuItems) {
          widget.saleItems[item] = SaleItemMenu(menuItem: item, quantity: 0, specialIndications: '');
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _listMenuItems.length,
        itemBuilder: (context, index) {
          final menuItem = _listMenuItems[index];
          final item = widget.saleItems[menuItem]!;
          return CardAddMenuOrderCustom(
            saleItemMenu: item,
            onIncrement: () => setState(() {
              if (item.quantity < 100) item.quantity = item.quantity + 1;
            }),
            onDecrement: () => setState(() {
              if (item.quantity > 0) item.quantity = item.quantity - 1;
            }),
          );
        },
      ),
    );
  }
}