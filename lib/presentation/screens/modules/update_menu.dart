import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

class UpdateMenuScreen extends StatelessWidget {  
  const UpdateMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UpdateMenuItemController>();
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
              final confirmar = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Eliminar'),
                    content: const Text('¿Estás seguro de eliminarlo?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                      TextButton(
                        child: const Text('Eliminar'),
                        onPressed: () => Navigator.pop(context, true),
                      ),
                    ],
                  );
                },
              );
              if (confirmar == true) {
                await context.read<MenuItemProvider>().deleteMenuItem(vm.id);
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
                              TextFormField(
                                controller: vm.nameC,
                                decoration: const InputDecoration(labelText: 'Nombre'),
                                validator: (v) => v != null && v.isNotEmpty
                                    ? null
                                    : 'Nombre inválido',
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: vm.descriptionC,
                                decoration: const InputDecoration(labelText: 'Descripción'),
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: vm.priceC,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(labelText: 'Precio'),
                                validator: (v) =>
                                    v != null && v.isNotEmpty ? null : 'Precio inválido',
                              ),
                              const SizedBox(height: 12),
                              DropdownButtonFormField<EnumMenuItemCategory>(
                                value: vm.type.value,
                                decoration: const InputDecoration(labelText: 'Categoría'),
                                items: EnumMenuItemCategory.values.map((t) =>
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
                            onPressed: () {
                              if (vm.formKey.currentState!.validate()) {
                                final userSave = MenuItem(
                                  name: vm.nameC.text.trim(),
                                  description: vm.descriptionC.text.trim(),
                                  price: double.parse(vm.priceC.text.trim()),
                                  category: vm.type.value,
                                  imageUrl: vm.image.value ?? '',
                                );
                                context.read<MenuItemProvider>().updateMenuItem(vm.id, userSave);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Guardado ✔️')),
                                );
                                Navigator.pop(context);
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