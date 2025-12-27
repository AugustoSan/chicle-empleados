import 'package:chicle_app_empleados/data/repository/repository.dart';

import '../entities/business.dart';

class InitializeBusinessUseCase {
  final BusinessRepositoryImpl repo;
  InitializeBusinessUseCase(this.repo);
  Future<void> call() => repo.initialize();
}

class LoadBusinessUseCase {
  final BusinessRepositoryImpl repo;
  LoadBusinessUseCase(this.repo);
  Future<Business?> call() => repo.loadBusiness();
}

class SaveBusinessConfigUseCase {
  final BusinessRepositoryImpl repo;
  SaveBusinessConfigUseCase(this.repo);
  Future<void> call(Business cfg) => repo.saveBusiness(cfg);
}

class SaveLogoUseCase {
  final BusinessRepositoryImpl repo;
  SaveLogoUseCase(this.repo);
  Future<void> call(String logoPath) => repo.saveLogo(logoPath);
}
