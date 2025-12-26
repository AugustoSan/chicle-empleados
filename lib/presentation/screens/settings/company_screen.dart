import 'package:flutter/material.dart';
import 'package:chicle_app_empleados/theme_data.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
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
            icon: const Icon(ChicleIcons.backPage),
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
                              TextFieldCustom(
                                controller: vm.nameC,
                                title: 'Nombre del negocio',
                                validator: (v) => v != null && v.isNotEmpty
                                    ? null
                                    : 'Nombre del negocio inválido',
                              ),
                              const SizedBox(height: 12),
                              TextFieldCustom(
                                controller: vm.addressC,
                                title: 'Dirección',
                                validator: (v) => v != null && v.isNotEmpty
                                    ? null
                                    : 'Dirección inválida',
                              ),
                              const SizedBox(height: 12),
                              TextFieldCustom(
                                controller: vm.phoneC,
                                title: 'Teléfono',
                                keyboardType: TextInputType.phone,
                                validator: (v) => v != null && v.isNotEmpty && v.length == 10
                                    ? null
                                    : 'Teléfono inválido',
                              ),
                              const SizedBox(height: 12),
                              TextFieldCustom(
                                controller: vm.initialCashC,
                                title: 'Efectivo inicial del día',
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 12),
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
                                  initialCash: double.parse(vm.initialCashC.text.trim()),
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
