import 'package:hive_flutter/hive_flutter.dart';
import '../../../domain/entities/business.dart';

abstract class ConfigLocalDataSource {
  Future<Business?> loadConfig();
  Future<void> saveConfig(Business config);
}

class ConfigHiveDataSource implements ConfigLocalDataSource {
  final box = Hive.box<Business>('config');

  @override
  Future<Business?> loadConfig() async =>
      box.get('business');

  @override
  Future<void> saveConfig(Business config) async {
    await box.put('business', config);
  }
}
