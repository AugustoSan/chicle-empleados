import '../entities/business.dart';
import '../repositories/business_repository.dart';

class InitializeBusinessUseCase {
  final BusinessRepository repo;
  InitializeBusinessUseCase(this.repo);
  Future<void> call() => repo.initialize();
}

class LoadBusinessUseCase {
  final BusinessRepository repo;
  LoadBusinessUseCase(this.repo);
  Future<Business?> call() => repo.loadBusiness();
}

class SaveBusinessConfigUseCase {
  final BusinessRepository repo;
  SaveBusinessConfigUseCase(this.repo);
  Future<void> call(Business cfg) => repo.saveBusiness(cfg);
}

class SaveLogoUseCase {
  final BusinessRepository repo;
  SaveLogoUseCase(this.repo);
  Future<void> call(String logoPath) => repo.saveLogo(logoPath);
}
