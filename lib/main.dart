// import 'dart:io';
import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/theme_data.dart';
// import '../data/local/app_database.dart';
import '../models/models.dart';
import '../presentation/screens/shellapp.dart';
// import 'package:path/path.dart' as p;

// Future<void> deleteOldDatabase() async {
//   final dir = await getApplicationDocumentsDirectory();
//   final dbFile = File(p.join(dir.path, 'db.sqlite'));
//   if (await dbFile.exists()) {
//     await dbFile.delete();
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Inicializa Hiveuser: admin
  await Hive.initFlutter();
  Hive.registerAdapter(AuthModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(BusinessModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());
  Hive.registerAdapter(OrderItemModelAdapter());
  Hive.registerAdapter(CashCutModelAdapter()); // Register the new adapter


  // await Hive.deleteBoxFromDisk(Boxes.authBox);
  // await Hive.deleteBoxFromDisk(Boxes.businessBox);
  // await Hive.deleteBoxFromDisk(Boxes.categoryBox);
  // await Hive.deleteBoxFromDisk(Boxes.ordersBox);
  // await Hive.deleteBoxFromDisk(Boxes.ordersItemBox);
  // await Hive.deleteBoxFromDisk(Boxes.productsBox);
  // await Hive.deleteBoxFromDisk(Boxes.cashCutBox);
  // await Hive.deleteBoxFromDisk(Boxes.usersBox);
  // 2) Inicializa Hive business
  // Hive.registerAdapter(CustomerModelAdapter());

  // await deleteOldDatabase();
  // 2) Inicializa Drift
  // final database = AppDatabase();

  await setupLocator();  
  // await setupLocator(database);  

  // Obtén la instancia y espera a que cargue
  final userProv = getIt<UserProvider>();
  await userProv.initialize();
  final businessProv = getIt<BusinessProvider>();
  await businessProv.initialize();

  // final customerProv = getIt<CustomerProvider>();
  // await customerProv.initialize();

  final authProv = getIt<AuthProvider>();
  await authProv.checkLogin();

  final cashCut = getIt<CashCutProvider>();
  await cashCut.getAllCashCuts();

  runApp(
    MultiProvider(
      providers: [
        // Singletons
        ChangeNotifierProvider<BusinessProvider>.value(value: businessProv..loadBusinessData()),
        ChangeNotifierProvider<CashCutProvider>(create: (_) => getIt<CashCutProvider>()),
        // ChangeNotifierProvider<CustomerProvider>.value(value: customerProv..loadCustomerData()),
        ChangeNotifierProvider<UserProvider>.value(value: userProv..loadAllUsers()),
        // Providers (creados y cargados al ser necesitados por primera vez)
        ChangeNotifierProvider<AuthProvider>(create: (_) => getIt<AuthProvider>()),
        ChangeNotifierProvider<CategoryProvider>(create: (_) => getIt<CategoryProvider>()..getAllCategories()),
        ChangeNotifierProvider<ProductProvider>(create: (_) => getIt<ProductProvider>()),
        // ViewModels
        ChangeNotifierProvider<LoginController>(create: (ctx) => LoginController(ctx.read<AuthProvider>())),
        ChangeNotifierProvider<BusinessController>(create: (ctx) => BusinessController(ctx.read<BusinessProvider>())),
        // ChangeNotifierProvider<CustomerProvider>(create: (ctx) => getIt<CustomerProvider>()),
        ChangeNotifierProvider<OrderProvider>(create: (ctx) => getIt<OrderProvider>()),
        ChangeNotifierProvider<AddOrderController>(
          create: (ctx) => AddOrderController(
            getIt<OrderRepository>(),
            getIt<UserProvider>(),
            // getIt<ProductProvider>()
          )
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProfileController>(
          create: (ctx) => ProfileController(ctx.read<UserProvider>(), ctx.read<AuthProvider>()),
          update: (ctx, authProv, ctrl) {
            final u = authProv.user;
            if (u != null) ctrl!.loadFromUser();
            return ctrl!;
          },
        ),
        // 6) ShellNavigatorController
        // ChangeNotifierProvider<ShellNavigatorController>(
        //   create: (ctx) => ShellNavigatorController(),
        // ),
        // ViewModels
        ChangeNotifierProvider(
          create: (ctx) => AddCashCutViewModel(
            orderRepository: getIt<OrderRepository>(),
            userRepository: getIt<UserRepository>(),
            cashCutProvider: getIt<CashCutProvider>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersViewModel(
            orderRepository: getIt<OrderRepository>(),
            authRepository: getIt<AuthRepository>(),
          ),
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
      debugShowCheckedModeBanner: false,

      home: Consumer<AuthProvider>(
        builder: (ctx, auth, _) =>
          auth.isLoggedIn ? ShellApp() : const LoginScreen(),
      ),
    );
  }
}
