import 'dart:io';

import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/theme_data.dart';
import '../data/local/app_database.dart';
import 'domain/di/locator.dart';
import '../models/models.dart';
import '../presentation/screens/shellapp.dart';
import 'package:path/path.dart' as p;

import 'presentation/screens/login/login_screen.dart';

Future<void> deleteOldDatabase() async {
  final dir = await getApplicationDocumentsDirectory();
  final dbFile = File(p.join(dir.path, 'db.sqlite'));
  if (await dbFile.exists()) {
    await dbFile.delete();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Inicializa Hiveuser: admin
  await Hive.initFlutter();
  Hive.registerAdapter(AuthModelAdapter());

  // await Hive.deleteBoxFromDisk(Boxes.authBox);
  // await Hive.deleteBoxFromDisk(Boxes.businessBox);
  // await Hive.deleteBoxFromDisk(Boxes.customersBox);
  // await Hive.deleteBoxFromDisk(Boxes.usersBox);
  // 2) Inicializa Hive business
  Hive.registerAdapter(BusinessModelAdapter());
  Hive.registerAdapter(CustomerModelAdapter());

  // await deleteOldDatabase();
  // 2) Inicializa Drift
  final database = AppDatabase();

  await setupLocator(database);  

  // Obtén la instancia y espera a que cargue
  final userProv = getIt<UserProvider>();
  // await userProv.initialize();
  final businessProv = getIt<BusinessProvider>();
  await businessProv.initialize();

  final customerProv = getIt<CustomerProvider>();
  await customerProv.initialize();

  final authProv = getIt<AuthProvider>();
  await authProv.initialize();

  runApp(
    MultiProvider(
      providers: [
        // Singletons
        ChangeNotifierProvider<BusinessProvider>.value(value: businessProv..loadBusinessData()),
        ChangeNotifierProvider<CustomerProvider>.value(value: customerProv..loadCustomerData()),
        ChangeNotifierProvider<UserProvider>.value(value: userProv..getCurrentUser()),
        ChangeNotifierProvider<MenuItemProvider>.value(value: getIt<MenuItemProvider>()..loadAll()),
        // Providers
        ChangeNotifierProvider<MenuItemProvider>(create: (_) => getIt<MenuItemProvider>()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => getIt<AuthProvider>()),
        // ViewModels
        ChangeNotifierProvider<LoginController>(create: (ctx) => LoginController(ctx.read<AuthProvider>())),
        ChangeNotifierProvider<BusinessController>(create: (ctx) => BusinessController(ctx.read<BusinessProvider>())),
        ChangeNotifierProvider<CustomerProvider>(create: (ctx) => getIt<CustomerProvider>()),
        ChangeNotifierProvider<SaleProvider>(create: (ctx) => getIt<SaleProvider>()),
        ChangeNotifierProvider<AddSaleController>(
          create: (ctx) => AddSaleController(
            getIt<SalesRepository>(),
            getIt<UserProvider>(),
            getIt<CustomerProvider>()
          )
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProfileController>(
          create: (ctx) => ProfileController(ctx.read<UserProvider>(), ctx.read<AuthProvider>()),
          update: (ctx, authProv, ctrl) {
            final u = authProv.username;
            if (u.isNotEmpty) ctrl!.loadFromUser();
            return ctrl!;
          },
        ),
        // 6) ShellNavigatorController
        ChangeNotifierProvider<ShellNavigatorController>(
          create: (ctx) => ShellNavigatorController(),
        ),
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

