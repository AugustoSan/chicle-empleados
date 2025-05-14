import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../domain/domain.dart';
import '../../providers/providers.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
} 

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _currencyC = TextEditingController();
  final _taxC = TextEditingController();
  BusinessType _selectedType = BusinessType.cafeteria;

  @override
  void initState() {
    super.initState();
    // Carga inicial desde el provider
    final biz = context.read<BusinessProvider>().business;
    if (biz != null) {
      _nameC.text     = biz.name;
      _currencyC.text = biz.currency;
      _taxC.text      = biz.taxPercent.toString();
      _selectedType   = biz.type;
    }
  }

  @override
  void dispose() {
    _nameC.dispose();
    _currencyC.dispose();
    _taxC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Form(                 // ← Aquí
                  key: _formKey,            // atachas tu key al Form
                  child: Container(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameC,
                          decoration: const InputDecoration(labelText: 'Nombre del negocio'),
                          validator: (v) => v != null && v.isNotEmpty
                              ? null
                              : 'Nombre del negocio inválido',
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _currencyC,
                          decoration: const InputDecoration(labelText: 'Moneda'),
                          validator: (v) =>
                              v != null && v.isNotEmpty ? null : 'Moneda inválida',
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _taxC,
                          decoration: const InputDecoration(labelText: 'Porcentaje de IVA'),
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'IVA requerido';
                            if (double.tryParse(v) == null) return 'Debe ser un número';
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<BusinessType>(
                          value: _selectedType,
                          decoration: const InputDecoration(labelText: 'Tipo de negocio'),
                          items: BusinessType.values.map((t) =>
                            DropdownMenuItem(value: t, child: Text(t.name))
                          ).toList(),
                          onChanged: (t) {
                            if (t != null) setState(() => _selectedType = t);
                          },
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Ahora currentState no es null y validate() funciona
                              if (_formKey.currentState!.validate()) {
                                final business = Business(
                                  name: _nameC.text.trim(),
                                  currency: _currencyC.text.trim(),
                                  taxPercent: double.parse(_taxC.text.trim()),
                                  type: _selectedType,
                                  enabledModules: [],
                                );
                                context.read<BusinessProvider>().saveBusiness(business);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Guardado ✔️')),
                                );
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              )
            ],
          ),
      );
  }

}
