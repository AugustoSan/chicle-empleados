import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/presentation/screens/home/resume_sale.dart';
// import 'package:chicle_app_empleados/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddOrderController>();
    final Map<Product,OrderItem> orderItems = vm.orderItems;
    final List<Product> listProducts = vm.listProducts;
    return SafeArea(
      child: Form(
        key: vm.formKey,  // ← usa la key local, no la de vm
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    const Text(
                            'Nueva orden',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: const Text(
                    //         'Nueva orden',
                    //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //     // IconButton(
                    //     //   icon: const Icon(ChicleIcons.refresh),
                    //     //   onPressed: () => vm.initForm(),
                    //     // ),
                    //   ],
                    // ),
                    const SizedBox(height: 12),
                    TextFieldCustom(
                      controller: vm.nameC,
                      title: 'Nombre del cliente',
                      validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nombre inválido';
                              }
                              return null;
                            },
                          ),
                    const SizedBox(height: 12),
                    ListItemsPriceQuantity(saleItems: orderItems, listProducts: listProducts,),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          final seleccionados = orderItems.entries
                            .where((item) => item.value.quantity > 0)
                            .map((item) => OrderItem.fromNewOrderItem(cantidad: item.value.quantity, producto: item.key, precio: item.value.priceAtOrder, indicaciones: item.value.specialIndications))
                            .toList();
                          //key)).toList();
                          for (var item in seleccionados) {
                            print('item: ${item.product.name}, quantity: ${item.quantity}');
                          }
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResumeSaleScreen(items: seleccionados, customer: 'Público en general',)));
                        },
                        child: const Text('Siguiente'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
