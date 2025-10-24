// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chicle_app_empleados/theme_data.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';
// import './add_users.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _users.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }

  Future<void> _init() async {
    final userProv = context.read<UserProvider>();
    await userProv.loadAllUsers();

    if(!mounted) return;

    final items = userProv.allUsers;

    setState(() {
      _users
        ..clear()
        ..addAll(items);
    });
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final currentUserEntity = authProvider.user;
    final currentUser = currentUserEntity?.username;
    final isAdmin = authProvider.isAdmin;
    print('users count: ${_users.length}');
    print('currentUser: ${currentUser}');
    // final shell = context.watch<ShellNavigatorController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        leading: IconButton(
          icon: const Icon(ChicleIcons.backPage),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(ChicleIcons.refresh),
            onPressed: () => _init(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: _users.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = _users[index];
                        final isCurrentUser = item.username == currentUser;
                        return CardUserCustomPortrait(
                          item: item,
                          isCurrentUser: isCurrentUser,
                          isAdmin: isAdmin,
                          reload: () => _init(),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(), 
                    )
                  );
                }
              )
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(ChicleIcons.add),
        onPressed: () => {
          Navigator.push(context, RouteUtils().getRouteAddUser()).then((_) => _init()),
        }
      ),
    );
  }
}
