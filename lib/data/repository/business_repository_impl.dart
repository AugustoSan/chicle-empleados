import 'package:hive/hive.dart';
import '../../models/businessModel.dart';
import '../../domain/domain.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final Box<BusinessModel> box;

  BusinessRepositoryImpl(this.box);

  @override
  Future<void> initialize() async {
    // box.clear();
    if (box.isEmpty) {
      await saveBusiness(Business(
        name:           'Cafetería',
        currency:       'MXN',
        taxPercent:     16.0,
        type:           BusinessType.cafeteria,
        enabledModules: ['bebidas', 'alimentos', 'menus', 'reportes', 'configuración'],
        logo:           null,
      ));
    }
  }

  @override
  Future<Business?> loadBusiness() async {
    if (box.isEmpty) return null;
    
    final model = box.getAt(0)!;
    
    return Business(
      name:           model.name,
      currency:       model.currency,
      taxPercent:     model.taxPercent,
      type:           BusinessType.values[model.type],
      enabledModules: model.enabledModules,
      address:        model.address,
      phone:          model.phone,
      logo:           model.logo,
    );
  }

  @override
  Future<void> saveBusiness(Business biz) async {
    // mapeamos entidad a modelo
    final model = BusinessModel(
      name:           biz.name,
      currency:       biz.currency,
      taxPercent:     biz.taxPercent,
      type:           biz.type.index,
      enabledModules: biz.enabledModules,
      address:        biz.address,
      phone:          biz.phone,
      logo:           biz.logo,
    );
    if (box.isEmpty) {
      await box.add(model);
    } else {
      print('BusinessRepositoryImpl.saveBusiness: ${model.name}');
      await box.putAt(0, model);
    }
  }

  @override
  Future<void> saveLogo(String logoPath) async {
    final model = box.getAt(0)!;
    model.logo = logoPath;
    
  }
}
