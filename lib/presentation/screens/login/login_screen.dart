import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext ctx) {
    final vm = ctx.watch<LoginController>();
    final business     = ctx.watch<BusinessProvider>().business;
    final primaryColor = Theme.of(ctx).primaryColor;
    final lightBlueBg  = Theme.of(ctx).colorScheme.secondary;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                  color: lightBlueBg,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: vm.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          business?.name ?? 'Chicle',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Iniciar sesión',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 32),

                        Container(
                          decoration: BoxDecoration(
                            color: lightBlueBg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: vm.usernameController,
                                decoration: const InputDecoration(
                                  hintText: 'Usuario',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 20),
                                ),
                                validator: (v) => 
                                  (v == null || v.isEmpty)
                                    ? 'Ingresa tu usuario' : null,
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: vm.passwordController,
                                decoration: const InputDecoration(
                                  hintText: 'Contraseña',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 20),
                                ),
                                obscureText: true,
                                validator: (v) => 
                                  (v == null || v.isEmpty)
                                    ? 'Ingresa tu contraseña' : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        if (vm.error != null)
                          Text(vm.error!, style: const TextStyle(color: Colors.red)),
                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: vm.loading
                                ? null
                                : () => vm.submit(ctx),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: vm.loading
                                ? const CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white)
                                : const Text('Iniciar Sesión',
                                    style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
