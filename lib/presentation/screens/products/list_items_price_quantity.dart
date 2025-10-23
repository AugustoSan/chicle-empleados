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
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _listProducts.clear();
    _orderItems.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }
  
  void _init(){
    context.read<ProductProvider>().loadAll();
    final products = context.read<ProductProvider>().allItems;
    setState(() {
      _listProducts.clear();
      _listProducts.addAll(products);
      if (_listProducts.isEmpty && products.isNotEmpty) {
        _listProducts.addAll(products);
        for (var item in products) {
          widget.saleItems[item] = OrderItem.fromProduct(item);
        }
      }
    });
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
            onAddDescription: (String? description) {
              setState(() {
                item.specialIndications = description;
              });
            },
          );
        },
      ),
    );
  }
}