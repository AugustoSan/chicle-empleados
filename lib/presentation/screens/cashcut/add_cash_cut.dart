import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCashCutScreen extends StatefulWidget {
  const AddCashCutScreen({Key? key}) : super(key: key);

  @override
  State<AddCashCutScreen> createState() => _AddCashCutScreenState();
}
class _AddCashCutScreenState extends State<AddCashCutScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddCashCutViewModel>().loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final controller = context.watch<AddCashCutController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Realizar corte de caja'),
      ),
      body: Consumer<AddCashCutViewModel>(
        builder: (context, viewModel, child) {
          if(viewModel.loading && viewModel.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if(viewModel.error != null && viewModel.users.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${viewModel.error}'),
                  ElevatedButton(
                    onPressed: viewModel.loadUsers,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          return Form(
            key: formKey,
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
                    child: _buildContent(viewModel),
                  )
                ),
                _buildSaveButton(viewModel),
              ],
            )
          );
        }
      ),
    );
  }

  Widget _buildContent(AddCashCutViewModel viewModel) {
    return ListView(
      children: [
        _buildUserDropdown(viewModel),
        const SizedBox(height: 16),
        const SectionTitle('Resumen de Ventas'),
        _buildSalesSummary(viewModel),
        const Divider(height: 24),
        const SectionTitle('Entradas del Usuario'),
        _buildUserInputs(viewModel),
        const Divider(height: 32),
        const SectionTitle('Resultado del Corte'),
        _buildCutResults(viewModel),
      ],
    );
  }
  
  Widget _buildUserDropdown(AddCashCutViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Usuario:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<User>(
          value: viewModel.selectedUser,
          items: viewModel.users.map((user) => DropdownMenuItem<User>(
            value: user,
            child: Text(user.username),
          )).toList(),
          onChanged: (user) {
            if (user != null) {
              viewModel.selectUser(user);
            }
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
  Widget _buildSalesSummary(AddCashCutViewModel viewModel) {
    return Column(
      children: [
        _buildInfoRow('(+) Fondo de Caja Inicial:', viewModel.initialCash),
        _buildInfoRow('(+) Ventas en Efectivo:', viewModel.cashSales),
        _buildInfoRow('(+) Ventas con Tarjeta:', viewModel.cardSales),
        _buildInfoRow('(+) Otras Formas de Pago:', viewModel.otherPaymentSales),
        _buildInfoRow('(=) Total Ventas:', viewModel.totalSales, isBold: true),
      ],
    );
  }

  Widget _buildUserInputs(AddCashCutViewModel viewModel) {
    return Column(
      children: [
        TextFieldCustom(
          controller: viewModel.countedCashC,
          title: 'Efectivo Contado en Caja',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Este campo es requerido';
            if (double.tryParse(value) == null) return 'Ingresa un número válido';
            return null;
          },
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        const SizedBox(height: 12),
        TextFieldCustom(
          controller: viewModel.cardPaymentsC,
          title: 'Transferencias y cobro con Tarjeta',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Este campo es requerido';
            if (double.tryParse(value) == null) return 'Ingresa un número válido';
            return null;
          },
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        const SizedBox(height: 12),
        TextFieldCustom(
          controller: viewModel.expensesC,
          title: '(-) Gastos y Egresos',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        const SizedBox(height: 12),
        TextFieldCustom(
          controller: viewModel.notesC,
          title: 'Notas (Opcional)',
          keyboardType: TextInputType.multiline,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }

  Widget _buildCutResults(AddCashCutViewModel viewModel) {
    return Column(
      children: [
        _buildInfoRow('(=) Efectivo Esperado:', viewModel.expectedCashInDrawer, isBold: true),
        _buildDifferenceRow(viewModel.difference),
      ],
    );
  }

  Widget _buildDifferenceRow(double difference) {
    final String sign = difference > 0 
        ? '(Sobrante)' 
        : difference < 0 
            ? '(Faltante)' 
            : '';
    
    final Color color = difference > 0 
        ? Colors.green 
        : difference < 0 
            ? Colors.red 
            : Colors.black;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Diferencia: $sign', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(
            PriceUtils.getStringPrice(difference),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(PriceUtils.getStringPrice(value), style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildSaveButton(AddCashCutViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: viewModel.loading ? null : () async {
          if (formKey.currentState!.validate()) {
            
            bool confirm = true;
          
            // Solo mostrar diálogo si hay diferencia
            if (viewModel.difference.abs() > 0.01) {
              final result = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Diferencia en Corte de Caja'),
                  content: const Text(
                    'Hay una diferencia entre el efectivo contado y el esperado. '
                    '¿Deseas continuar y que la cantidad se sume o reste al final del corte de caja?'
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Si'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, null),
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
              );
              // Si result es null (usuario cerró el diálogo), salir sin hacer nada
              if (result == null) {
                return; // Sale del onPressed sin guardar
              }
              
              confirm = result;
            }

            await viewModel.saveCashCut(confirm);
            
            if (viewModel.error == null && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Corte guardado con éxito')),
              );
              Navigator.pop(context);
            } else if (viewModel.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(viewModel.error!)),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
        child: viewModel.loading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Guardar Corte de Caja', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
