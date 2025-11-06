import 'package:chicle_app_empleados/domain/domain.dart';

class SaveCashCutUseCase {
  final CashCutRepository repo;
  SaveCashCutUseCase(this.repo);
  Future<void> call(CashCut cashCut) => repo.saveCashCut(cashCut);
}

class GetCashCutUseCase {
  final CashCutRepository repo;
  GetCashCutUseCase(this.repo);
  Future<CashCut?> call(String id) => repo.getCashCut(id);
}

class GetAllCashCutsUseCase {
  final CashCutRepository repo;
  GetAllCashCutsUseCase(this.repo);
  Future<List<CashCut>> call() => repo.getAllCashCuts();
}

class UpdateCashCutUseCase {
  final CashCutRepository repo;
  UpdateCashCutUseCase(this.repo);
  Future<void> call(String id, CashCut cashCut) => repo.updateCashCut(id, cashCut);
}

class DeleteCashCutUseCase {
  final CashCutRepository repo;
  DeleteCashCutUseCase(this.repo);
  Future<void> call(String id) => repo.deleteCashCut(id);
}

class GetLastCashCutUseCase {
  final CashCutRepository repo;
  GetLastCashCutUseCase(this.repo);
  Future<CashCut?> call() => repo.getLastCashCut();
}