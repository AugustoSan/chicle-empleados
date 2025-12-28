import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';

/// Widget que dibuja el recibo
class CashCutResume extends StatelessWidget {
  final CashCut data;
  final String user;
  const CashCutResume({Key? key, required this.data, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 500,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Corte de caja #${StringUtil.hideMiddle(data.id)}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 24, thickness: 1),
              const SizedBox(height: 16),
              _buildInfoRow('Usuario:', user),
              const Divider(height: 24, thickness: 1),
              const SizedBox(height: 16),
              Text(
                'Información de ventas',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 24, thickness: 1),
              _buildInfoRow('Efectivo:', PriceUtils.getStringPrice(data.cashSales)),
              _buildInfoRow('Tarjeta:', PriceUtils.getStringPrice(data.cardSales)),
              _buildInfoRow('Otros:', PriceUtils.getStringPrice(data.otherPaymentSales)),
              _buildInfoRow('Total:', PriceUtils.getStringPrice(data.totalSales)),
              const Divider(height: 24, thickness: 1),
              const SizedBox(height: 16),
              Text(
                'Información del corte de caja',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 24, thickness: 1),
              _buildInfoRow('Fecha:', DateUtil.formatDateTime(data.date)),
              _buildInfoRow('Efectivo inicial:', PriceUtils.getStringPrice(data.initialCash)),
              _buildInfoRow('Total de ventas:', PriceUtils.getStringPrice(data.totalSales)),
              _buildInfoRow('Efectivo final en caja:', PriceUtils.getStringPrice(data.countedCash)),
              _buildInfoRow('Gastos/Egresos:', PriceUtils.getStringPrice(data.expenses)),
              _buildInfoRow('Diferencia:', PriceUtils.getStringPrice(data.difference)),
              _buildInfoRow('Notas:', data.notes ?? 'Sin notas'),
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
