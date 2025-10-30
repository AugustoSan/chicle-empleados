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
  final List<Category> _listCategories = [];
  final List<Product> _listProducts = [];
  final Map<Product,OrderItem> _orderItems = {};
  double total = 0;

  String? error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final categoryProv = context.read<CategoryProvider>();
    await categoryProv.loadAll();

    if(!mounted) return;

    final categories = categoryProv.allItems;
    final newOrderItems = _getOrderItems(categories);
    setState(() {
      _listCategories.clear();
      _listCategories.addAll(categories);
      _listProducts.clear();
      _listProducts.addAll(categories.expand((c) => c.items));
      _orderItems.clear();
      _orderItems.addAll(newOrderItems);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _listCategories.clear();
    _orderItems.clear();
  }

  void saveOrder(List<OrderItem> items) async {
    if (!formKey.currentState!.validate()) return;

    final userProv = context.read<UserProvider>();
    final orderProv = context.read<OrderProvider>();
    final categoryProv = context.read<CategoryProvider>();

    final user = await userProv.getCurrentUser();
    await categoryProv.loadAll();
    if(!mounted) return;
    if (user == null) return;

    final res = await orderProv.saveOrder(
      Order.withoutId(
        userId: user.id, 
        customer: 'Público en general',
        status: EnumOrderStatus.pending, 
        date: DateTime.now(), 
        items: items.toList()
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

    final categories = categoryProv.allItems;
    final newOrderItems = _getOrderItems(categories);
    setState(() {
      _listCategories.clear();
      _listCategories.addAll(categories);
      _listProducts.clear();
      _listProducts.addAll(categories.expand((c) => c.items));
      _orderItems.clear();
      _orderItems.addAll(newOrderItems);
      total = 0;
    });
    return;
  }

  Map<Product, OrderItem> _getOrderItems(List<Category> categories) {
    final Map<Product, OrderItem> map = {};
    for (var item in categories) {
      for (var product in item.items) {
        map[product] = OrderItem.fromProduct(product);
      }
    }
    return map;
  }

  void _updateTotal() {
    double temp = 0;
    for (final e in _orderItems.entries) {
      if (e.value.quantity > 0) {
        temp += e.value.quantity * e.key.price;
      }
    }

    setState(() {
      total = temp;
    });
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
                child: _listProducts.isEmpty 
                  ? const Center(child: const Text("Sin productos registrados")) 
                  : Column(
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                              'Nueva orden',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                      const SizedBox(height: 12),
                      TextTitleWithContent(title: 'Total: ', content: PriceUtils.getStringPrice(total)),
                      const SizedBox(height: 12),
                      ListItemsPriceQuantity(saleItems: _orderItems, listProducts: _listProducts, onQuantityChanged: _updateTotal,),
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
