import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';
import '../utils/utils.dart';

class BusinessController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final currencyC = TextEditingController();
  final taxC = TextEditingController();
  final ValueNotifier<String?> logoC = ValueNotifier<String?>(null);
  final ValueNotifier<BusinessType> selectedType = ValueNotifier<BusinessType>(BusinessType.cafeteria);

  bool  _loading = false;
  String? _error;
  bool  get loading => _loading;
  String? get error => _error;

  final BusinessProvider _businessProvider;

  BusinessController(this._businessProvider)
  {
    final biz = _businessProvider.business;
    if (biz != null) {
      nameC.text     = biz.name;
      currencyC.text = biz.currency;
      taxC.text      = biz.taxPercent.toString();
      selectedType.value   = BusinessType.cafeteria;
      logoC.value          = biz.logo;
    }
  }


  Future<void> save(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    _loading = true;
    _error   = null;
    notifyListeners();

    final ok = await _businessProvider.saveBusiness(
      Business(
        name: nameC.text,
        currency: currencyC.text,
        taxPercent: double.parse(taxC.text),
        type: BusinessType.cafeteria,
        logo: logoC.value, enabledModules: [],
      )
    );

    _loading = false;
    if (!ok) _error = 'Ocurrio un error al guardar';
    notifyListeners();
  }

  Future<void> saveLogo() async {
    final imageUrl = await Picture().saveImage(PictureType.business);

    if(imageUrl != null){
      logoC.value = imageUrl;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    nameC.dispose();
    currencyC.dispose();
    taxC.dispose();
    logoC.dispose();
    selectedType.dispose();
    super.dispose();
  }
}
