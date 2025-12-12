import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CashCutScreen extends StatelessWidget {
  const CashCutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CashCutProvider>();
    final listCashCut = provider.allItems;
    print('list: ${listCashCut}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Corte de caja'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: listCashCut.length > 0 
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: listCashCut.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = listCashCut[index];
                          return ListTile(
                            title: Text(item.id),
                            subtitle: Column(
                              children: [
                                  Text(item.userId),
                                  Text(item.date.toString()),
                                  Text(item.countedCash.toString()),
                                  Text(item.cashSales.toString()),
                                  Text(item.cardSales.toString()),
                                  Text(item.otherPaymentSales.toString()),
                                  Text(item.expenses.toString()),
                                  Text(item.notes != null ? item.notes! : ''),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                      ),
                    );
                  }
                )
              : Center(child: Text('No hay corte de caja')),

            ),  
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => Navigator.push(context, RouteUtils().getRouteAddCashCut()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
