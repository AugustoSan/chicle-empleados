// import 'dart:io';

import 'package:chicle_app_empleados/presentation/screens/auth/add_users.dart';
import 'package:chicle_app_empleados/presentation/screens/settings/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late Future<List<Auth>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _fetchUsers();
  }

  Future<List<Auth>> _fetchUsers() {
    return context.read<AuthProvider>().getAllUsers();
  }

  // void _refreshUsers() {
  //   setState(() {
  //     _usersFuture = _fetchUsers();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final authProvider = context.read<AuthProvider>();
    // final currentUser = authProvider.username;
    final shell = context.watch<ShellNavigatorController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Auth>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final users = snapshot.data!;
          if (users.isEmpty) {
            return const Center(child: Text('No hay usuarios registrados'));
          }
          final authProvider = context.read<AuthProvider>();
          final currentUser = authProvider.username;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            itemBuilder: (context, i) {
              final u = users[i];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(child: Text(u.username[0], style: const TextStyle(fontSize: 20))),
                  title: Text(u.username),
                  subtitle: Text('@${u.username}'),
                  trailing: u.username == currentUser ? IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      if(u.username == currentUser) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                      }
                    },
                  ) : authProvider.role == 'administrador' ? IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmar eliminación'),
                          content: Text('¿Estás seguro de que deseas eliminar al usuario "${u.username}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                final success = await context.read<UserProvider>().deleteUserDB(u.username);
                                final successAuth = await context.read<AuthProvider>().deleteUser(username: u.username);
                                Navigator.pop(context); // Cerrar el diálogo
                                if (success && successAuth) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Usuario "${u.username}" eliminado correctamente')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error al eliminar al usuario "${u.username}"')),
                                  );
                                }
                              },
                              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ) : const SizedBox.shrink(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => shell.navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (ctx) => AddUserController(ctx.read<AuthProvider>()), 
                child: const AddUserScreen()
              )
            )
          ),
      ),
    );
  }
}
