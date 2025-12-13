// import 'package:chicle_app_empleados/data/repository/order_item_repository_impl.dart';
// import 'package:chicle_app_empleados/data/repository/product_repository_impl.dart';
import 'package:chicle_app_empleados/data/datasource/hive_data_source.dart';
import 'package:hive/hive.dart';
import 'package:get_it/get_it.dart';
import '../../../models/models.dart';
import '../../../data/data.dart';
import '../domain.dart';
import '../../../presentation/presentation.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // --- Data Sources ---
  getIt.registerLazySingleton<HiveDataSource>(() => HiveDataSourceImpl());

  // --- Autenticación ---
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(HiveDataSourceImpl()),
  );
  getIt.registerFactory<AuthProvider>(
    () => AuthProvider(getIt<AuthRepository>())..checkLogin(),
  );

  // --- Negocio ---
  final businessBox = await Hive.openBox<BusinessModel>(Boxes.businessBox);
  getIt.registerLazySingleton<BusinessRepository>(
    () => BusinessRepositoryImpl(businessBox),
  );
  getIt.registerFactory<BusinessProvider>(
    () => BusinessProvider(getIt<BusinessRepository>()),
  );

  // --- Usuarios ---
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(HiveDataSourceImpl()),
  );
  getIt.registerFactory<UserProvider>(
    () => UserProvider(getIt<UserRepository>(), getIt<AuthRepository>()),
  );

  // --- Productos ---
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(HiveDataSourceImpl()),
  );
  getIt.registerFactory<ProductProvider>(
    () => ProductProvider(getIt<ProductRepository>()),
  );

  // --- Categorías ---
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<HiveDataSource>()),
  );
  getIt.registerFactory<CategoryProvider>(
    () => CategoryProvider(getIt<CategoryRepository>()),
  );

  // --- OrderItem ---
  getIt.registerLazySingleton<OrderItemRepository>(
    () => OrderItemRepositoryImp(),
  );
  getIt.registerFactory<OrderItemProvider>(
    () => OrderItemProvider(getIt<OrderItemRepository>()),
  );  

  // --- Ordenes ---
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(),
  );
  getIt.registerFactory<OrderProvider>(
    () => OrderProvider(getIt<OrderRepository>(), getIt<AuthRepository>()),
  ); 

  // --- CashCut ---
  getIt.registerLazySingleton<CashCutRepository>(
    () => CashCutRepositoryImpl(getIt<HiveDataSource>()),
  );
  getIt.registerFactory<CashCutProvider>(
    () => CashCutProvider(getIt<CashCutRepository>()),
  ); 
}
