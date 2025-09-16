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
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _sales.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _init() async {
    final saleProv = context.read<SaleProvider>();
    await saleProv.loadAll();

    if(!mounted) return;

    final items = saleProv.allSales;

    setState(() {
      _sales.clear();
      _sales.addAll(items);
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<SaleProvider>();
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