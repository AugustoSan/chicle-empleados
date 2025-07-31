// import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:provider/provider.dart';

class OrdersPortrait extends StatefulWidget {
  const OrdersPortrait({Key? key}) : super(key: key);

  @override
  State<OrdersPortrait> createState() => _OrdersPortraitState();
}

class _OrdersPortraitState extends State<OrdersPortrait> {
  final List<Sales> _sales = [];
  @override
  void initState() {
    super.initState();
    context.read<SaleProvider>().loadAll();
    final items = context.read<SaleProvider>().allSales;
    _sales.addAll(items);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final items = context.read<SaleProvider>().allSales;
    if (_sales.isEmpty && items.isNotEmpty) {
      _sales.addAll(items);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<SaleProvider>();
    
    // final salesAll = provider.allSales;

    for (var i = 0; i < _sales.length; i++) {
      print('ID sale : ${_sales[i].id}');
    }

    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: _sales.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = _sales[index];
                      return CardOrderCustomPortrait(item: item);
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  ),
                );
              }
            ),
          ),
        ),
      ],
    );
  }
}