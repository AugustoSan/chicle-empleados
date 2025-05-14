import 'package:chicle_app_empleados/presentation/providers/login_provider.dart';
import 'package:chicle_app_empleados/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../data/local/app_database.dart';
import 'domain/di/locator.dart';
import '../models/businessModel.dart';
import '../models/authModel.dart';
import '../presentation/providers/auth_provider.dart';
import '../presentation/providers/menuitem_provider.dart';
import '../presentation/providers/user_provider.dart';
import '../presentation/screens/shellapp.dart';

import 'presentation/providers/business_provider.dart';
import 'presentation/screens/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Inicializa Hive
  await Hive.initFlutter();
  Hive.registerAdapter(AuthModelAdapter());
  Hive.registerAdapter(BusinessModelAdapter());

  // 2) Inicializa Drift
  final database = AppDatabase();

  await setupLocator(database);  

  // Obtén la instancia y espera a que cargue
  final userProv = getIt<UserProvider>();
  await userProv.initialize();
  final businessProv = getIt<BusinessProvider>();
  await businessProv.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => businessProv..loadBusinessData()),
        ChangeNotifierProvider(create: (_) => getIt<MenuItemProvider>()),
        ChangeNotifierProvider(create: (_) => userProv),
        ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
        ChangeNotifierProvider(create: (ctx) => LoginViewModel(ctx.read<AuthProvider>())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Punto de Venta',
      theme: chicleTheme,

      home: Consumer<AuthProvider>(
        builder: (ctx, auth, _) =>
          auth.isLoggedIn ? ShellApp() : const LoginScreen(),
      ),
    );
  }
}

