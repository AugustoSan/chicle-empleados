import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// import '../../../domain/domain.dart';

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
                              ContainerAddPicture(onSaveImage: vm.saveImage, rutaImagen: vm.imageProfile.value),
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
                                enabled: false,
                                controller: vm.usernameC,
                                decoration: const InputDecoration(labelText: 'Nombre de usuario'),
                                validator: (v) =>
                                    v != null && v.isNotEmpty ? null : 'Nombre de usuario inválido',
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                enabled: false,
                                obscureText: true,
                                controller: vm.passwordC,
                                decoration: const InputDecoration(labelText: 'Contraseña'),
                                validator: (v) =>
                                    v != null && v.isNotEmpty ? null : 'Contraseña inválida',
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (vm.formKey.currentState!.validate()) {
                                // final userSave = User(
                                //   id: vm.id,
                                //   name: vm.nameC.text.trim(),
                                //   username: vm.usernameC.text.trim(),
                                //   passwordHash: vm.passwordC.text.trim(),
                                //   imageUrl: vm.imageProfile.value ?? '',
                                // );
                                // context.read<UserProvider>().saveUser(userSave);
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(content: Text('Guardado ✔️')),
                                // );
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
