import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateOrder extends StatefulWidget {
  final int idSale;
  const UpdateOrder({Key? key, required this.idSale}) : super(key: key);

  @override
  _UpdateOrderState createState() => _UpdateOrderState();
}

class _UpdateOrderState extends State<UpdateOrder> {
  final Map<MenuItem,SaleItemMenu> _saleItems = {};
  final List<MenuItem> _listMenuItems = [];
  Sales? _sale;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _listMenuItems.clear();
    _saleItems.clear();
  }

  Future<void> _init() async {
    final menuProv = context.read<MenuItemProvider>();
    final saleProv = context.read<SaleProvider>();
    await menuProv.loadAll();

    final sale = await saleProv.getSale(widget.idSale);

    if(!mounted || sale == null) return;

    print('customer: ${sale.customer}');

    final items = menuProv.allItems;

    final Map<int, SaleItemMenu> map = {};
    for (final item in items) {
      final existing = sale.items.firstWhere(
        (e) => e.menuItem.id == item.id,
        orElse: () => SaleItemMenu(
          menuItem: item, 
          quantity: 0, 
          specialIndications: '',
        ),
      );
      map[item.id!] = existing;
    }

    setState(() {
      _sale = sale;
      _listMenuItems
        ..clear()
        ..addAll(items);
      _saleItems
        ..clear()
        ..addEntries(
          map.entries.map((e) => MapEntry(
            items.firstWhere((it) => it.id == e.key),
            e.value,
          )),
        );
    });
    
  }

  Future<void> _save(List<SaleItemMenu> items) async {
    if(_sale == null) return;
    _sale!.items = items;
    final saleProv = context.read<SaleProvider>();
    await saleProv.updateSale(_sale!.id!, _sale!);
  }

  @override
  Widget build(BuildContext context) {
    if (_sale == null) {
      return const Center(
        child: Text('No se encontro la orden'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Orden'),
            Text(' # ${_sale!.id}')
          ],
        ),
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
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitleWithContent(title: 'Cliente: ', content: _sale!.customer),
                const SizedBox(height: 12),
                TextTitleWithContent(title: 'Fecha: ', content: _sale!.date.toString()),
              ],
            )
          ),
          const SizedBox(height: 12),
          ListItemsPriceQuantity(saleItems: _saleItems),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () {
                print('Presionado');
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
  
                _save(seleccionados);
                Navigator.pop(context);
                Navigator.pop(context);
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