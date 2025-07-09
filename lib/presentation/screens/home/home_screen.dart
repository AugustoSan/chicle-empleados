import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // <-- FormKey local, único para esta instancia de pantalla
  final _formKey = GlobalKey<FormState>();
  final Map<MenuItem,int> _quantities = {};

  @override
  void initState() {
    super.initState();
    context.read<MenuItemProvider>().loadAll();
    final items = context.read<MenuItemProvider>().allItems;
    for (var item in items) {
      _quantities[item] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddSaleController>();

    final listMenuItems = context.watch<MenuItemProvider>().allItems;

    print('listMenuItems: ${listMenuItems.length}');

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
                    TextFormField(
                            controller: vm.nameC,
                            decoration: const InputDecoration(
                              labelText: 'Nombre del cliente',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nombre inválido';
                              }
                              return null;
                            },
                          ),
                    const SizedBox(height: 12),
                    Expanded(
                      // child: GridView.builder(
                      //   primary: false,
                      //   padding: const EdgeInsets.all(20),
                      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 2,
                      //     crossAxisSpacing: 10,
                      //     mainAxisSpacing: 10,
                      //   ),
                      //   itemBuilder: (context, index) {
                      //     final item = listMenuItems[index];
                      //     return CardAddMenuOrderCustom(item: item);
                      //   },
                      //   itemCount: listMenuItems.length,
                      // )
                      child: ListView.builder(
                        itemCount: listMenuItems.length,
                        itemBuilder: (context, index) {
                          final item = listMenuItems[index];
                          final qty = _quantities[item] ?? 0;
                          return CardAddMenuOrderCustom(
                            item: item,
                            quantity: qty,
                            onIncrement: () => setState(() {
                              if (qty < 100) _quantities[item] = qty + 1;
                            }),
                            onDecrement: () => setState(() {
                              if (qty > 0) _quantities[item] = qty - 1;
                            }),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          print('onpress');
                          final seleccionados = _quantities.entries
                            .where((e) => e.value > 0)
                            .map((e) => SaleItemMenu(
                              menuItem: e.key,
                              quantity: e.value,
                              specialIndications: '',
                            )).toList();
                          for (var item in seleccionados) {
                            print('item: ${item.menuItem.name}, quantity: ${item.quantity}');
                          }
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
