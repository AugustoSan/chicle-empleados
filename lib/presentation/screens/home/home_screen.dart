import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext ctx) {
    final username = ctx.watch<AuthProvider>().username;
    return Center(child: Text('Has iniciado sesión como:\n$username'));
  }
}
