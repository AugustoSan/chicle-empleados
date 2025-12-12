import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCashCutScreen extends StatefulWidget {
  const AddCashCutScreen({Key? key}) : super(key: key);

  @override
  State<AddCashCutScreen> createState() => _AddCashCutScreenState();
}
class _AddCashCutScreenState extends State<AddCashCutScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AddCashCutController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Realizar corte de caja'),
      ),
      body: controller.loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView(
                        children: [
                          const SectionTitle('Resumen de Ventas'),
                          _buildInfoRow('(+) Fondo de Caja Inicial:', controller.initialCash),
                          _buildInfoRow('(+) Ventas en Efectivo:', controller.cashSales),
                          // _buildInfoRow('(+) Ventas con Tarjeta:', controller.cardSales),
                          _buildInfoRow('(+) Otras Formas de Pago:', controller.otherPaymentSales),
                          const Divider(height: 24),
                          
                          const SectionTitle('Entradas del Usuario'),
                          TextFieldCustom(
                            controller: controller.countedCashC,
                            title: 'Efectivo Contado en Caja',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo es requerido';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Ingresa un número válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFieldCustom(
                            controller: controller.countedCashC,
                            title: 'Transferencias y cobro con Tarjeta',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo es requerido';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Ingresa un número válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFieldCustom(
                            controller: controller.expensesC,
                            title: '(-) Gastos y Egresos',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) {
                              if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
                                return 'Ingresa un número válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFieldCustom(
                            controller: controller.notesC,
                            title: 'Notas (Opcional)',
                            keyboardType: TextInputType.multiline,
                          ),
                          const Divider(height: 32),

                          const SectionTitle('Resultado del Corte'),
                          _buildInfoRow('(=) Efectivo Esperado:', controller.expectedCashInDrawer, isBold: true),
                           _buildResultRow(
                            'Diferencia:',
                            (double.tryParse(controller.countedCashC.text) ?? 0.0) - controller.expectedCashInDrawer,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final res = await controller.save(context);
                        if (res.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Corte de caja guardado con éxito ✔️')),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $res')),
                          );
                        }
                      },
                      child: const Text('Guardar Corte de Caja'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String title, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(PriceUtils.getStringPrice(value), style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildResultRow(String title, double difference) {
    final Color color = difference > 0 ? Colors.green : (difference < 0 ? Colors.red : Colors.black);
    final String sign = difference > 0 ? '(Sobrante)' : (difference < 0 ? '(Faltante)' : '');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(
            '${PriceUtils.getStringPrice(difference)} $sign',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
