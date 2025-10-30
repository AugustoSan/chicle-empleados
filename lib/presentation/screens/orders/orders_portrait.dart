// import 'package:chicle_app_empleados/domain/domain.dart';
// import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:provider/provider.dart';

class OrdersPortrait extends StatelessWidget {
  const OrdersPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProv = context.watch<OrderProvider>();
    final orders = orderProv.allOrders;

    return Column(
      children: [
        Expanded(
          child: orders.length == 0
            ? const Center(child: Text('No hay ordenes'))
            : Container(
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
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = orders[index];
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