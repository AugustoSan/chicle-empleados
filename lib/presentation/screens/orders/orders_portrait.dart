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
    status: EnumSalesStatus.completed,
    date: DateTime.now(),
    items: [SaleItemMenu(
      quantity: 1, 
      menuItem: MenuItem.empty(),
      specialIndications: '',
    )]);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,                // para que no expanda infinito
            physics: ScrollPhysics().parent, // anida en scroll padre
            itemCount: 38,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              // ajustar ratio ancho/alto de cada tile:
              childAspectRatio: 5, // más ancho que alto (3:1)
            ),
            itemBuilder: (context, index) {
              final item = sales;
              int position = index % 3;
              sales.status = EnumSalesStatus.values[position];
              return CardOrderCustomLandscape(item: item);
            },
          ),
        );
      }
    );
  }
}