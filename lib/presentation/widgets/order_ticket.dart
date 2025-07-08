import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Widget que dibuja el recibo
class ReceiptWidget extends StatelessWidget {
  final Sales data;
  const ReceiptWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print('ReceiptWidget: ${data.id}');
    final business = context.read<BusinessProvider>().business;
    // Cálculos
    final subtotal = data.items.fold<double>(
      0,
      (sum, it) => sum + it.total * it.quantity,
    );
    final taxPercent = business?.taxPercent ?? 0.16;
    final tax = subtotal * taxPercent;
    final total = subtotal + tax;

    print('Business: ${business?.name}, address: ${business?.address}, phone: ${business?.phone}');


    return Column(
      children: [
        Container(
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
          // Encabezado
          Text(
            business?.name ?? 'Sin nombre',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(business?.address ?? '', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          Text(business?.phone ?? '', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          const Divider(height: 24, thickness: 1),

          // Info de ticket
          _buildInfoRow('Cliente:', 'Publico en general'),
          _buildInfoRow('Ticket #:', data.id.toString()),
          _buildInfoRow('Fecha:', DateUtil.formatDateTime(data.date)),
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
          ...data.items.map((it) {
            final lineTotal = it.total * it.quantity;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Expanded(flex: 4, child: Text(it.menuItem.name, style: const TextStyle(fontSize: 12))),
                  Expanded(flex: 1, child: Text('${it.quantity}', textAlign: TextAlign.right, style: const TextStyle(fontSize: 12))),
                  Expanded(flex: 2, child: Text(PriceUtils.getStringPrice(lineTotal), textAlign: TextAlign.right, style: const TextStyle(fontSize: 12))),
                ],
              ),
            );
          }).toList(),

          const Divider(height: 24, thickness: 1),

          // Subtotales, impuesto y total
          _buildInfoRow('Subtotal:', PriceUtils.getStringPrice(subtotal), alignRight: true),
          _buildInfoRow('IVA (${(taxPercent).toInt()}%):', PriceUtils.getStringPrice(tax), alignRight: true),
          _buildInfoRow(
            'Total:',
            PriceUtils.getStringPrice(total),
            alignRight: true,
            valueStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),
          Text(
            '¡Gracias por tu compra!',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    )
      ],
    );
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
}
