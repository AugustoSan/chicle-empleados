import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateOrder extends StatefulWidget {
  final Sales sale;
  const UpdateOrder({Key? key, required this.sale}) : super(key: key);

  @override
  _UpdateOrderState createState() => _UpdateOrderState();
}

class _UpdateOrderState extends State<UpdateOrder> {
  final Map<MenuItem,SaleItemMenu> _saleItems = {};
  final List<MenuItem> _listMenuItems = [];

  @override
  void initState() {
    super.initState();
    final saleItems = widget.sale.items;
    for (var item in saleItems) {
      print('id: ${item.menuItem.id}');
      print('name: ${item.menuItem.name}');
      print('price: ${item.menuItem.price}');
      print('quantity: ${item.quantity}');
      print('specialIndications: ${item.specialIndications}');
    }
    context.read<MenuItemProvider>().loadAll();
    final menuItems = context.read<MenuItemProvider>().allItems;
    _listMenuItems.addAll(menuItems);
    for (var item in menuItems) {
      SaleItemMenu saleItemMenu = saleItems.firstWhere((element) => element.menuItem.id == item.id, orElse: () => SaleItemMenu(menuItem: item, quantity: 0, specialIndications: ''));
      print('id: ${item.id}           == ${saleItemMenu.menuItem.id}');
      print('name: ${item.name}       == ${saleItemMenu.menuItem.name}');
      print('price: ${item.price}     == ${saleItemMenu.menuItem.price}');
      print('quantity: ${saleItemMenu.quantity}');
      print('specialIndications: ${saleItemMenu.specialIndications}');
      _saleItems[item] = saleItemMenu;
    }
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar orden'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
        children: [
          const SizedBox(height: 12),
          Text('Orden # ${widget.sale.id}', style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 12),
          ListItemsPriceQuantity(saleItems: _saleItems),
          const SizedBox(height: 12),
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
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ResumeSaleScreen(items: seleccionados, customer: vm.nameC.text,)));
              },
              child: const Text('Guardar'),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
      )
    );
  }
}