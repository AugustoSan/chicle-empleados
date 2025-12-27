import 'package:chicle_app_empleados/data/data.dart';
import 'package:chicle_app_empleados/domain/domain.dart';

class SaveCashCutUseCase {
  final CashCutRepositoryImpl repo;
  SaveCashCutUseCase(this.repo);
  Future<void> call(CashCut cashCut) => repo.saveCashCut(cashCut);
}

class GetCashCutUseCase {
  final CashCutRepositoryImpl repo;
  GetCashCutUseCase(this.repo);
  Future<CashCut?> call(String id) => repo.getCashCut(id);
}

class GetAllCashCutsUseCase {
  final CashCutRepositoryImpl repo;
  GetAllCashCutsUseCase(this.repo);
  Future<List<CashCut>> call() => repo.getAllCashCuts();
}

class UpdateCashCutUseCase {
  final CashCutRepositoryImpl repo;
  UpdateCashCutUseCase(this.repo);
  Future<void> call(String id, CashCut cashCut) => repo.updateCashCut(id, cashCut);
}

class DeleteCashCutUseCase {
  final CashCutRepositoryImpl repo;
  DeleteCashCutUseCase(this.repo);
  Future<void> call(String id) => repo.deleteCashCut(id);
}

class GetLastCashCutUseCase {
  final CashCutRepositoryImpl repo;
  GetLastCashCutUseCase(this.repo);
  Future<CashCut?> call() => repo.getLastCashCut();
}