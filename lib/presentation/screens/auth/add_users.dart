import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddUserController>();
    final shell = context.watch<ShellNavigatorController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar usuario'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => {
            Navigator.pushNamed(context, DrawerProducts.menu.route),
            shell.setSecondRoute('/addUser'),
          }
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
                              TextFieldCustom(
                                controller: vm.usernameC,
                                title: 'Nombre de usuario',
                                validator: (v) => v != null && v.isNotEmpty
                                    ? null
                                    : 'Nombre de usuario inválido',
                              ),
                              const SizedBox(height: 12),
                              PasswordField(
                                controller: vm.passwordC,
                                title: 'Contraseña',
                              ),
                              const SizedBox(height: 12),
                              DropdownButtonFormField<EnumRole>(
                                value: vm.role.value,
                                decoration: const InputDecoration(labelText: 'Tipo de usuario'),
                                items: EnumRole.values.map((t) =>
                                  DropdownMenuItem(value: t, child: Text(t.name))
                                ).toList(),
                                onChanged: (t) {
                                  if (t != null) vm.role.value = t;
                                },
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              final res = await vm.save(context);
                              if (res != '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(res)),
                                );
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Guardado ✔️')),
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