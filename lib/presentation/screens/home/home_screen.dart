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
  final List<MenuItem> _listMenuItems = [];
  final Map<MenuItem,SaleItemMenu> _saleItems = {};

  @override
  void initState() {
    super.initState();
    context.read<MenuItemProvider>().loadAll();
    final menuItems = context.read<MenuItemProvider>().allItems;
    _listMenuItems.addAll(menuItems);
    for (var item in menuItems) {
      _saleItems[item] = SaleItemMenu(
        menuItem: item,
        quantity: 0,
        specialIndications: '',
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      final menuItems = context.watch<MenuItemProvider>().allItems;
      if (_listMenuItems.isEmpty && menuItems.isNotEmpty) {
        _listMenuItems.addAll(menuItems);
        for (var item in menuItems) {
          _saleItems[item] = SaleItemMenu(menuItem: item, quantity: 0, specialIndications: '');
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddSaleController>();

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
                    ListItemsPriceQuantity(saleItems: _saleItems),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          final seleccionados = _saleItems.entries
                            .where((e) => e.value.quantity > 0)
                            .map((e) => SaleItemMenu(
                              menuItem: e.key,
                              quantity: e.value.quantity,
                              specialIndications: e.value.specialIndications,
                            )).toList();
                          for (var item in seleccionados) {
                            print('item: ${item.menuItem.name}, quantity: ${item.quantity}');
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
