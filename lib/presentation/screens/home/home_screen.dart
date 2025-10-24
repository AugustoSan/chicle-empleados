import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/presentation/screens/home/resume_sale.dart';
// import 'package:chicle_app_empleados/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  final List<Product> _listProducts = [];
  final Map<Product,OrderItem> _orderItems = {};

  String? error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final prov = context.read<ProductProvider>();
    await prov.loadAll();

    if(!mounted) return;

    final products = prov.allItems;
    final Map<Product, OrderItem> map = {};
    for (var item in products) {
      map[item] = OrderItem.fromProduct(item);
    }
    setState(() {
      _listProducts.clear();
      _listProducts.addAll(products);
      _orderItems.clear();
      _orderItems.addEntries(map.entries);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _listProducts.clear();
    _orderItems.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }

  void saveOrder() async {
    if (!formKey.currentState!.validate()) return;

    final userProv = context.read<UserProvider>();
    final orderProv = context.read<OrderProvider>();
    final prov = context.read<ProductProvider>();

    final user = await userProv.getCurrentUser();
    await prov.loadAll();
    if(!mounted) return;
    if (user == null) return;

    final res = await orderProv.saveOrder(
      Order.withoutId(
        userId: user.id, 
        customer: 'Público en general',
        status: EnumOrderStatus.pending, 
        date: DateTime.now(), 
        items: _orderItems.values.toList()
      )
    );

    if(!res) {
      setState(() {
        error = 'Ocurrio un error al guardar';
      });
      return;
    }
    setState(() {
      error = null;
    });

    final products = prov.allItems;
    final Map<Product, OrderItem> newOrderItems = {};
    for (var item in products) {
      newOrderItems[item] = OrderItem.fromProduct(item);
    }
    setState(() {
      _listProducts.clear();
      _listProducts.addAll(products);
      _orderItems.clear();
      _orderItems.addAll(newOrderItems);
    });
    return;
  }


  @override
  Widget build(BuildContext context) {
    // final vm = context.watch<AddOrderController>();
    return SafeArea(
      child: Form(
        key: formKey,  // ← usa la key local, no la de vm
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
                    // const SizedBox(height: 12),
                    // TextFieldCustom(
                    //   controller: vm.nameC,
                    //   title: 'Nombre del cliente',
                    //   validator: (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return 'Nombre inválido';
                    //           }
                    //           return null;
                    //         },
                    //       ),
                    const SizedBox(height: 12),
                    ListItemsPriceQuantity(saleItems: _orderItems, listProducts: _listProducts,),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResumeSaleScreen(items: seleccionados, customer: 'Público en general', submit: saveOrder,)));
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
