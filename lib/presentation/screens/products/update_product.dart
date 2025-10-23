import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

class UpdateProductScreen extends StatelessWidget {  
  const UpdateProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UpdateProductController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar la carta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              final confirmar = await mostrarDeleteDialog(context);
              if (confirmar == true) {
                await context.read<ProductProvider>().deleteProduct(vm.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Eliminado ✔️')),
                );
                Navigator.pop(context);
              }
            },
          )
        ],
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
                              ContainerAddPicture(onSaveImage: vm.saveImage, rutaImagen: vm.image.value),
                              const SizedBox(height: 12),
                              TextFieldCustom(
                                controller: vm.nameC,
                                title: 'Nombre',
                                validator: (v) => v != null && v.isNotEmpty
                                    ? null
                                    : 'Nombre inválido',
                              ),
                              const SizedBox(height: 12),
                              TextFieldCustom(
                                controller: vm.descriptionC,
                                title: 'Descripción',
                              ),
                              const SizedBox(height: 12),
                              TextFieldCustom(
                                controller: vm.priceC,
                                keyboardType: TextInputType.number,
                                title: 'Precio',
                                validator: (v) =>
                                    v != null && v.isNotEmpty ? null : 'Precio inválido',
                              ),
                              const SizedBox(height: 12),
                              DropdownButtonFormField<EnumProductCategory>(
                                value: vm.type.value,
                                decoration: const InputDecoration(labelText: 'Categoría'),
                                items: EnumProductCategory.values.map((t) =>
                                  DropdownMenuItem(value: t, child: Text(t.name))
                                ).toList(),
                                onChanged: (t) {
                                  if (t != null) vm.type.value = t;
                                },
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              final error = await vm.save(context);
                              if (error.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error)),
                                );
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Guardado ✔️')),
                              );
                              Navigator.pop(context);
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