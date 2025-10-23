import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateOrder extends StatefulWidget {
  final String idOrder;
  const UpdateOrder({Key? key, required this.idOrder}) : super(key: key);

  @override
  _UpdateOrderState createState() => _UpdateOrderState();
}

class _UpdateOrderState extends State<UpdateOrder> {
  final Map<Product,OrderItem> _saleItems = {};
  final List<Product> _listProducts = [];
  Order? _sale;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _listProducts.clear();
    _saleItems.clear();
  }

  Future<void> _init() async {
    final menuProv = context.read<ProductProvider>();
    final saleProv = context.read<OrderProvider>();
    await menuProv.loadAll();

    final sale = await saleProv.getOrder(widget.idOrder);

    if(!mounted || sale == null) return;

    print('customer: ${sale.customer}');

    final items = menuProv.allItems;

    final Map<String, OrderItem> map = {};
    for (final item in items) {
      final existing = sale.items.firstWhere(
        (e) => e.product.id == item.id,
        orElse: () => OrderItem.fromProduct(item),
      );
      map[item.id] = existing;
    }

    setState(() {
      _sale = sale;
      _listProducts
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

  Future<void> _save(List<OrderItem> items) async {
    if(_sale == null) return;
    _sale!.items = items;
    final saleProv = context.read<OrderProvider>();
    await saleProv.updateOrder(_sale!.id, _sale!);
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
          icon: const Icon(ChicleIcons.backPage),
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
                  .map((e) => OrderItem.withoutIds(
                    product: e.key,
                    quantity: e.value.quantity,
                    priceAtOrder: e.key.price,
                    specialIndications: e.value.specialIndications,
                  )).toList();
                for (var item in seleccionados) {
                  print('item: ${item.product.name}, quantity: ${item.quantity}');
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