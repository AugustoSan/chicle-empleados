import 'package:hive/hive.dart';
import 'package:get_it/get_it.dart';
import '../../../models/models.dart';
import '../../../data/data.dart';
import '../domain.dart';
import '../../../presentation/presentation.dart';

final getIt = GetIt.instance;

Future<void> setupLocator(AppDatabase db) async {

  // --- Negocio ---
  final businessBox = await Hive.openBox<BusinessModel>(Boxes.businessBox);
  getIt.registerLazySingleton<BusinessRepository>(
    () => BusinessRepositoryImpl(businessBox),
  );
  getIt.registerFactory<BusinessProvider>(
    () => BusinessProvider(getIt<BusinessRepository>()),
  );

  // --- Clientes ---
  final customerBox = await Hive.openBox<CustomerModel>(Boxes.customersBox);
  getIt.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(customerBox),
  );
  getIt.registerFactory<CustomerProvider>(
    () => CustomerProvider(getIt<CustomerRepository>()),
  );

  // --- Usuarios ---
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(db),
  );
  getIt.registerFactory<UserProvider>(
    () => UserProvider(getIt<UserRepository>(), getIt<AuthProvider>()),
  );

  // --- Ventas ---
  getIt.registerLazySingleton<SalesRepository>(
    () => SalesRepositoryImpl(db),
  );
  getIt.registerFactory<SaleProvider>(
    () => SaleProvider(getIt<SalesRepository>()),
  );

  // --- Autenticación ---
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );
  getIt.registerFactory<AuthProvider>(
    () => AuthProvider(getIt<AuthRepository>())..checkLogin(),
  );

  // --- MenuItems ---
  getIt.registerLazySingleton<MenuItemRepository>(
    () => MenuItemRepositoryImpl(db),
  );
  getIt.registerFactory<MenuItemProvider>(
    () => MenuItemProvider(getIt<MenuItemRepository>()),
  );
}
