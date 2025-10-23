import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItemsPriceQuantity extends StatefulWidget {
  final Map<Product,OrderItem> saleItems;
  const ListItemsPriceQuantity({Key? key, required this.saleItems}) : super(key: key);

  @override
  _ListItemsPriceQuantityState createState() => _ListItemsPriceQuantityState();
}

class _ListItemsPriceQuantityState extends State<ListItemsPriceQuantity> {
  final List<Product> _listProducts = [];
  final Map<Product,OrderItem> _orderItems = {};
  

  @override
  void initState() {
    super.initState();
    context.read<ProductProvider>().loadAll();
    final menuItems = context.read<ProductProvider>().allItems;
    _listProducts.addAll(menuItems);
    for (var item in menuItems) {
      _orderItems[item] = 
        widget.saleItems[item] ?? OrderItem.fromProduct(item);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      final products = context.watch<ProductProvider>().allItems;
      if (_listProducts.isEmpty && products.isNotEmpty) {
        _listProducts.addAll(products);
        for (var item in products) {
          widget.saleItems[item] = OrderItem.fromProduct(item);
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _listProducts.length,
        itemBuilder: (context, index) {
          final menuItem = _listProducts[index];
          final item = widget.saleItems[menuItem]!;
          return CardAddOrderItemCustom(
            orderItem: item,
            onIncrement: () => setState(() {
              if (item.quantity < 100) {
                setState(() {
                  item.quantity = item.quantity + 1;
                });
              }
            }),
            onDecrement: () => setState(() {
              if (item.quantity > 0){
                setState(() {
                  item.quantity = item.quantity - 1;
                });
              }
            }),
          );
        },
      ),
    );
  }
}