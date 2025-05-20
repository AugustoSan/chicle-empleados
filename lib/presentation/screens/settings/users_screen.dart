import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: context.read<UserProvider>().getAllUsers(),
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
              final u = users[i];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: u.imageUrl.isNotEmpty
                      ? CircleAvatar(backgroundImage: FileImage(File(u.imageUrl)))
                      : const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(u.name),
                  subtitle: Text('@${u.username}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Abre edición: cargar ProfileController con u y navegar
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
