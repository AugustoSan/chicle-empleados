import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chicle_app_empleados/domain/domain.dart';
import './../../presentation.dart';

class OrdersLandscape extends StatefulWidget {
  const OrdersLandscape({Key? key}) : super(key: key);

  @override
  State<OrdersLandscape> createState() => _OrdersLandscapeState();
}

class _OrdersLandscapeState extends State<OrdersLandscape> {

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
  void initState() {
    super.initState();
    context.read<SaleProvider>().loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SaleProvider>();

    final salesPending = provider.pendientes;
    final salesCompleted = provider.completados;
    final salesCancelled = provider.cancelados;

    if(salesPending.isEmpty && salesCompleted.isEmpty && salesCancelled.isEmpty) {
      // return const Center(child: Text('No hay ordenes'));
      /**
       * GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 5,
              mainAxisSpacing: 1,
              crossAxisCount: 3,
              children: <Widget>[
                CardOrderCustomLandscape(item: sales),
                CardOrderCustomLandscape(item: sales),
                CardOrderCustomLandscape(item: sales),
                CardOrderCustomLandscape(item: sales),
              ],
            ),
       */
      return LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth < 600 ? 2 : 3;
          return Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,                // para que no expanda infinito
            physics: ScrollPhysics().parent, // anida en scroll padre
            itemCount: 28,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              // ajustar ratio ancho/alto de cada tile:
              childAspectRatio: 6, // más ancho que alto (3:1)
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ordenes
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: const Text("He'd have you all unravel at the"),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[200],
                child: const Text('Heed not the rabble'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[300],
                child: const Text('Sound of screams but the'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[400],
                child: const Text('Who scream'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[500],
                child: const Text('Revolution is coming...'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[600],
                child: const Text('Revolution, they...'),
              ),
            ],
          )
        )
      ],
    );
  }
}