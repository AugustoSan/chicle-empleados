import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';

class OrdersPortrait extends StatefulWidget {
  const OrdersPortrait({Key? key}) : super(key: key);

  @override
  State<OrdersPortrait> createState() => _OrdersPortraitState();
}

class _OrdersPortraitState extends State<OrdersPortrait> {
  Sales sales = Sales.withAll(
    id: 1,
    userId: 0,
    customer: 'Publico en general',
    status: EnumSalesStatus.completed,
    date: DateTime.now(),
    items: [SaleItemMenu(
      quantity: 1, 
      menuItem: MenuItem.empty(),
      specialIndications: '',
    )]);

  @override
  Widget build(BuildContext context) {

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
                    itemCount: 38,
                    itemBuilder: (BuildContext context, int index) {
                      final item = sales;
                      item.id = index + 1;
                      item.date = DateTime.now();
                      item.status = EnumSalesStatus.values[index % 3]; // quitar
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