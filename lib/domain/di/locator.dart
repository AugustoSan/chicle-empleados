// lib/di/locator.dart
import 'package:hive/hive.dart';
import '../../../data/data.dart';
import '../../../domain/entities/boxes.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/menuitem_repository.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../models/businessModel.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/menuitem_provider.dart';
import '../../../presentation/providers/user_provider.dart';
import '../repositories/business_repository.dart';
import '../../presentation/providers/business_provider.dart';
import 'package:get_it/get_it.dart';

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

  // --- Usuarios ---
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(db),
  );
  getIt.registerFactory<UserProvider>(
    () => UserProvider(getIt<UserRepository>()),
  );

  // --- Autenticación ---
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(db),
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
