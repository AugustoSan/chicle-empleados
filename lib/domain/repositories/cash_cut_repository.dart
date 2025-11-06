import '../domain.dart';

abstract class CashCutRepository {
  /// Guarda un nuevo corte de caja en la base de datos.
  Future<void> saveCashCut(CashCut cashCut);

  /// Obtiene un corte de caja específico por su ID.
  Future<CashCut?> getCashCut(String id);

  /// Obtiene una lista de todos los cortes de caja, usualmente ordenados por fecha.
  Future<List<CashCut>> getAllCashCuts();

  /// Actualiza un corte de caja existente.
  /// Podría ser útil si se necesita corregir algún dato después de guardado.
  Future<void> updateCashCut(String id, CashCut cashCut);

  /// Elimina un corte de caja por su ID.
  Future<void> deleteCashCut(String id);

  /// Obtiene el último corte de caja realizado.
  Future<CashCut?> getLastCashCut();
}