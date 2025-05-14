import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameC  = TextEditingController();
  final _passC   = TextEditingController();
  bool  _loading = false;
  String? _error;

  @override
  Widget build(BuildContext ctx) {
    final business     = ctx.watch<BusinessProvider>().business;
    final primaryColor = Theme.of(ctx).primaryColor;
    final lightBlueBg  = Theme.of(ctx).colorScheme.secondary;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.all(0),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Título
                    Text(
                      business?.name ?? 'Chicle',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        fontSize: 24,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // FORM
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Contenedor blanco con dos campos separados por Divider
                          Container(
                            decoration: BoxDecoration(
                              color: lightBlueBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _usernameC,
                                  decoration: const InputDecoration(
                                    hintText: 'Usuario',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 20),
                                  ),
                                  validator: (v) => (v == null || v.isEmpty)
                                      ? 'Ingresa tu usuario'
                                      : null,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _passC,
                                  decoration: const InputDecoration(
                                    hintText: 'Contraseña',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 20),
                                  ),
                                  obscureText: true,
                                  validator: (v) => (v == null || v.isEmpty)
                                      ? 'Ingresa tu contraseña'
                                      : null,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          if (_error != null)
                            Text(
                              _error!,
                              style: const TextStyle(color: Colors.red),
                            ),
                                
                          // Botón de envío
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _loading ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _loading
                                  ? const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Iniciar Sesión',
                                      style: TextStyle(fontSize: 18),
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),

      // -- BARRA INFERIOR --
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: 1, // si quieres destacar el icono “lock”
        selectedItemColor: primaryColor,
        unselectedItemColor: primaryColor.withOpacity(0.4),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.lock_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });

    final auth = context.read<AuthProvider>();
    final ok   = await auth.login(_usernameC.text, _passC.text);

    setState(() { _loading = false; });
    if (!ok) {
      setState(() { _error = 'Credenciales incorrectas'; });
    }
    // si OK, AuthProvider notifica y rebuild muestra HomeScreen
  }
}
