import 'package:chicle_app_empleados/data/datasource/hive_data_source.dart';
import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/models/models.dart';

class CashCutRepositoryImpl implements CashCutRepository {
  static const _CASH_CUT_BOX = Boxes.cashCutBox;
  final HiveDataSource _hiveDataSource;

  CashCutRepositoryImpl(this._hiveDataSource);

  @override
  Future<void> saveCashCut(CashCut cashCut) async {
    final box = await _hiveDataSource.openBox<CashCutModel>(_CASH_CUT_BOX);
    final model = cashCut.toModel();
    await box.put(model.id, model);
  }

  @override
  Future<CashCut?> getCashCut(String id) async {
    final box = await _hiveDataSource.openBox<CashCutModel>(_CASH_CUT_BOX);
    final model = box.get(id);
    if (model == null) return null;
    return CashCut.fromModel(model);
  }

  @override
  Future<List<CashCut>> getAllCashCuts() async {
    final box = await _hiveDataSource.openBox<CashCutModel>(_CASH_CUT_BOX);
    final models = box.values.toList();
    // Ordenar por fecha, del más reciente al más antiguo
    models.sort((a, b) => b.date.compareTo(a.date));
    return models.map((model) => CashCut.fromModel(model)).toList();
  }

  @override
  Future<void> updateCashCut(String id, CashCut cashCut) async {
    final box = await _hiveDataSource.openBox<CashCutModel>(_CASH_CUT_BOX);
    final exists = box.containsKey(id);
    if (!exists) {
      throw Exception('El corte de caja con id $id no existe y no puede ser actualizado.');
    }
    final model = cashCut.toModel();
    await box.put(id, model);
  }

  @override
  Future<void> deleteCashCut(String id) async {
    final box = await _hiveDataSource.openBox<CashCutModel>(_CASH_CUT_BOX);
    await box.delete(id);
  }

  @override
  Future<CashCut?> getLastCashCut() async {
    final box = await _hiveDataSource.openBox<CashCutModel>(_CASH_CUT_BOX);
    if (box.isEmpty) {
      return null;
    }
    // Los valores se ordenan por fecha para obtener el último
    final models = box.values.toList();
    models.sort((a, b) => a.date.compareTo(b.date));
    final lastModel = models.last;
    return CashCut.fromModel(lastModel);
  }
}