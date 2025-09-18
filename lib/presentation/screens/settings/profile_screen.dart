import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
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
                // const HeaderCustom(title: 'Perfil', onBack: false,),
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
                              // ContainerAddPicture(onSaveImage: vm.saveImage, rutaImagen: vm.imageProfile.value),
                              const SizedBox(height: 12),
                              // TextFieldCustom(
                              //   controller: vm.nameC,
                              //   title: 'Nombre',
                              //   validator: (v) => v != null && v.isNotEmpty
                              //       ? null
                              //       : 'Nombre inválido',
                              // ),
                              // const SizedBox(height: 12),
                              TextFieldCustom(
                                enabled: true,
                                controller: vm.usernameC,
                                title: 'Nombre de usuario',
                                validator: (v) =>
                                    v != null && v.isNotEmpty ? null : 'Nombre de usuario inválido',
                              ),
                              const SizedBox(height: 12),
                              PasswordField(controller: vm.passwordC, title: 'Contraseña actual',),
                              const SizedBox(height: 12),
                              PasswordField(controller: vm.passwordNewC, title: 'Contraseña nueva'),
                              const SizedBox(height: 12),
                              PasswordField(controller: vm.passwordConfirmC, title: 'Confirmar contraseña nueva', validator: (v) => vm.passwordNewC.text == vm.passwordConfirmC.text ? null : 'Las contraseñas no coinciden'),
                            ],
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (vm.formKey.currentState!.validate()) {
                                final res = await vm.save(context);
                                if (res.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(res)),
                                  );
                                }
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
