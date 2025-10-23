import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import '../../presentation.dart';

class ResumeSaleScreen extends StatefulWidget {
  final String customer;
  final List<OrderItem> items;
  const ResumeSaleScreen({Key? key, required this.items, required this.customer}) : super(key: key);

  @override
  _ResumeSaleScreenState createState() => _ResumeSaleScreenState();
}

class _ResumeSaleScreenState extends State<ResumeSaleScreen> {
  // <-- FormKey local, único para esta instancia de pantalla
  final List<OrderItem> _items = [];
  String nameCustomer = '';

  @override
  void initState() {
    super.initState();
    nameCustomer = widget.customer.isEmpty ? 'Publico en general' : widget.customer;
    _items.addAll(widget.items);
  }

  Widget _buildInfoRow(String label, String value, {bool alignRight = false, TextStyle? valueStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
          Expanded(
            child: Text(
              value,
              textAlign: alignRight ? TextAlign.right : TextAlign.left,
              style: valueStyle ?? const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaleItemRow(OrderItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(flex: 4, child: Text(item.product.name, style: const TextStyle(fontSize: 12))),
              Expanded(flex: 1, child: Text('${item.quantity}', textAlign: TextAlign.right, style: const TextStyle(fontSize: 12))),
              Expanded(flex: 2, child: Text(PriceUtils.getStringPrice(item.total), textAlign: TextAlign.right, style: const TextStyle(fontSize: 12))),
            ],
          ),
          if (item.specialIndications != null)
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 2.0),
                child: Text(item.specialIndications!, style: const TextStyle(fontSize: 12)),
              ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final business     = context.watch<BusinessProvider>().business;
    final _formKey = GlobalKey<FormState>();

    final subtotal = _items.fold<double>(
      0,
      (sum, it) => sum + it.total,
    );
    // final taxPercent = business?.taxPercent ?? 16;
    // final tax = subtotal * taxPercent / 100;
    // final total = subtotal + tax;
    final total = subtotal;

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
                    // Encabezado
                    Text("Resumen de venta", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        width: 300, // ancho fijo para impresión en POS
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Info de ticket
                            _buildInfoRow('Cliente:', nameCustomer),
                            _buildInfoRow('Fecha:', DateUtil.formatDate(DateTime.now())),
                            const Divider(height: 24, thickness: 1),

                            // Encabezados de la tabla
                            Row(
                              children: const [
                                Expanded(flex: 4, child: Text('Concepto', style: TextStyle(fontWeight: FontWeight.bold))),
                                Expanded(flex: 1, child: Text('Cant.', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                                Expanded(flex: 2, child: Text('Importe', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // Filas de artículos
                            ..._items.map((it) => _buildSaleItemRow(it)),

                            const Divider(height: 24, thickness: 1),

                            // Subtotales, impuesto y total
                            // _buildInfoRow('Subtotal:', PriceUtils.getStringPrice(subtotal), alignRight: true),
                            // _buildInfoRow('IVA (${(taxPercent).toInt()}%):', PriceUtils.getStringPrice(tax), alignRight: true),
                            _buildInfoRow(
                              'Total:',
                              PriceUtils.getStringPrice(total),
                              alignRight: true,
                              valueStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Cancelar'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                await context.read<AddOrderController>().saveSale(context, _items);
                                //  Navigator.pushNamed(context, '/home');
                                 Navigator.pop(context);
                              },
                              child: const Text('Confirmar'),
                            ),
                          ),
                        ),
                      ],
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
