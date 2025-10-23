import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/presentation/screens/home/resume_sale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // <-- FormKey local, único para esta instancia de pantalla
  final _formKey = GlobalKey<FormState>();
  // final Map<MenuItem,int> _quantities = {};
  final List<Product> _listProducts = [];
  final Map<Product,OrderItem> _orderItems = {};

  @override
  void initState() {
    super.initState();
    context.read<ProductProvider>().loadAll();
    final products = context.read<ProductProvider>().allItems;
    _listProducts.addAll(products);
    for (var item in products) {
      _orderItems[item] = OrderItem.fromProduct(item);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      final products = context.watch<ProductProvider>().allItems;
      if (_listProducts.isEmpty && products.isNotEmpty) {
        _listProducts.addAll(products);
        for (var item in products) {
          _orderItems[item] = OrderItem.fromProduct(item);
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddOrderController>();

    return SafeArea(
      child: Form(
        key: _formKey,  // ← usa la key local, no la de vm
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
                    ListItemsPriceQuantity(saleItems: _orderItems),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          final seleccionados = _orderItems.entries
                            .where((item) => item.value.quantity > 0)
                            .map((item) => OrderItem.fromNewOrderItem(cantidad: item.value.quantity, producto: item.key, precio: item.value.priceAtOrder, indicaciones: item.value.specialIndications))
                            .toList();
                          //key)).toList();
                          for (var item in seleccionados) {
                            print('item: ${item.product.name}, quantity: ${item.quantity}');
                          }
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResumeSaleScreen(items: seleccionados, customer: vm.nameC.text,)));
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
