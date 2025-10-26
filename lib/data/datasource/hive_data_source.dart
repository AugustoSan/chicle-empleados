import 'package:hive/hive.dart';

/// Contrato abstracto para una fuente de datos de Hive.
abstract class HiveDataSource {
  /// Abre una caja de Hive de forma genérica.
  /// Si la caja ya está abierta, la devuelve. Si no, la abre y la devuelve.
  Future<Box<T>> openBox<T>(String boxName);
  Future<void> close<T>(String boxName);
}

/// Implementación concreta de [HiveDataSource].
class HiveDataSourceImpl implements HiveDataSource {
  @override
  Future<Box<T>> openBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) return Hive.box<T>(boxName);
    return await Hive.openBox<T>(boxName);
  }
  @override
  Future<void> close<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.box<T>(boxName);
      await box.close();
    }
  }
}