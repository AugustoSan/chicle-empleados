import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
import '../../presentation.dart';

class ResumeSaleScreen extends StatefulWidget {
  final String customer;
  final List<SaleItemMenu> items;
  const ResumeSaleScreen({Key? key, required this.items, required this.customer}) : super(key: key);

  @override
  _ResumeSaleScreenState createState() => _ResumeSaleScreenState();
}

class _ResumeSaleScreenState extends State<ResumeSaleScreen> {
  // <-- FormKey local, único para esta instancia de pantalla
  final List<SaleItemMenu> _items = [];
  String nameCustomer = '';

  @override
  void initState() {
    super.initState();
    nameCustomer = widget.customer.isEmpty ? 'Publico en general' : widget.customer;
    _items.addAll(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    // final vm = context.watch<AddSaleController>();
    final _formKey = GlobalKey<FormState>();

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
                      'Resumen de la orden',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text('Cliente: $nameCustomer'),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          final total = item.quantity * item.menuItem.price;
                          return ListTileCustom(
                            title: item.menuItem.name,
                            subtitle: Text(item.specialIndications.isEmpty ? 'Sin indicaciones especiales jhhgjhj jfgf jft jfft' : item.specialIndications, overflow: TextOverflow.ellipsis, maxLines: 4, ),
                            // imageUrl: item.menuItem.imageUrl,
                            onTap: () => mostrarDescriptionOrderMenuItemDialog(context, item.menuItem),
                            trailing: Text(PriceUtils.getStringPrice(total)),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancelar'),
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
