// import 'dart:io';

import 'package:chicle_app_empleados/presentation/screens/settings/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';
import './add_users.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _fetchUsers();
  }

  Future<List<User>> _fetchUsers() {
    return context.read<UserProvider>().getAllUsers();
  }

  void _refreshUsers() {
    setState(() {
      _usersFuture = _fetchUsers();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshUsers();
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final currentUser = authProvider.user;
    final isAdmin = authProvider.isAdmin;
    final shell = context.watch<ShellNavigatorController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<User>>(
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
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            itemBuilder: (context, i) {
              
              final userItem = users[i];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(child: Text(userItem.username[0], style: const TextStyle(fontSize: 20))),
                  title: Text(userItem.username),
                  subtitle: Text('@${userItem.username}'),
                  trailing: userItem.username == currentUser ? IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      if(userItem.username == currentUser) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                      }
                    },
                  ) : isAdmin ? IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmar eliminación'),
                          content: Text('¿Estás seguro de que deseas eliminar al usuario "${userItem.username}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                final success = await context.read<UserProvider>().deleteUser(user: userItem);
                                Navigator.pop(context); // Cerrar el diálogo
                                if (success) {
                                  _refreshUsers();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Usuario "${userItem.username}" eliminado correctamente')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error al eliminar al usuario "${userItem.username}"')),
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
                create: (ctx) => AddUserController(ctx.read<UserProvider>()), 
                child: const AddUserScreen()
              )
            )
          ),
      ),
    );
  }
}
