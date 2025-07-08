import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../domain/domain.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BusinessController>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Negocio'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Form(
            key: vm.formKey,
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
                    height:500,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              ContainerAddPicture(onSaveImage: vm.saveLogo, rutaImagen: vm.logoC.value),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: vm.nameC,
                                decoration: const InputDecoration(labelText: 'Nombre del negocio'),
                                validator: (v) => v != null && v.isNotEmpty
                                    ? null
                                    : 'Nombre del negocio inválido',
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: vm.addressC,
                                decoration: const InputDecoration(labelText: 'Dirección'),
                                validator: (v) => v != null && v.isNotEmpty
                                    ? null
                                    : 'Dirección inválida',
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: vm.phoneC,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(labelText: 'Teléfono'),
                                validator: (v) => v != null && v.isNotEmpty && v.length == 10
                                    ? null
                                    : 'Teléfono inválido',
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: vm.currencyC,
                                decoration: const InputDecoration(labelText: 'Moneda'),
                                validator: (v) =>
                                    v != null && v.isNotEmpty ? null : 'Moneda inválida',
                                    ),
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      controller: vm.taxC,
                                      decoration: const InputDecoration(labelText: 'Porcentaje de IVA'),
                                      keyboardType: TextInputType.number,
                                      validator: (v) {
                                        if (v == null || v.isEmpty) return 'IVA requerido';
                                        if (double.tryParse(v) == null) return 'Debe ser un número';
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    // DropdownButtonFormField<BusinessType>(
                                    //   value: vm.selectedType.value,
                                    //   decoration: const InputDecoration(labelText: 'Tipo de negocio'),
                                    //   items: BusinessType.values.map((t) =>
                                    //     DropdownMenuItem(value: t, child: Text(t.name))
                                    //   ).toList(),
                                    //   onChanged: (t) {
                                    //     if (t != null) setState(() => _selectedType = t);
                                    //   },
                                    // ),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (vm.formKey.currentState!.validate()) {
                                final business = Business(
                                  name: vm.nameC.text.trim(),
                                  currency: vm.currencyC.text.trim(),
                                  taxPercent: double.parse(vm.taxC.text.trim()),
                                  address: vm.addressC.text.trim(),
                                  phone: vm.phoneC.text.trim(),
                                  type: vm.selectedType.value,
                                  enabledModules: [],
                                  logo: vm.logoC.value,
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
              ],
            ),
          ),
        ),
      );
  }

}
