import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';

class CashCut extends StatefulWidget {
  const CashCut({Key? key}) : super(key: key);
  @override
  State<CashCut> createState() => _CashCutState();
}

class _CashCutState extends State<CashCut> {
  
  @override
  Widget build(BuildContext context) {
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
              child: const Center(child: Text('No hay corte de caja')),

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
