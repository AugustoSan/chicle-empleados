import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';
import '../utils/utils.dart';

class BusinessController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final addressC = TextEditingController();
  final phoneC = TextEditingController(); 
  final currencyC = TextEditingController();
  final taxC = TextEditingController();
  final initialCashC = TextEditingController();
  final ValueNotifier<String?> logoC = ValueNotifier<String?>(null);
  final ValueNotifier<BusinessType> selectedType = ValueNotifier<BusinessType>(BusinessType.cafeteria);

  bool  _loading = false;
  String? _error;
  bool  get loading => _loading;
  String? get error => _error;

  final BusinessProvider _businessProvider;

  BusinessController(this._businessProvider)
  {

    _businessProvider.addListener(_onBusinessChanged);

    // Si ya tiene datos, cargarlos
    if (_businessProvider.business != null) {
      _populateFields();
    } else {
      // Si no, cargarlos async
      _loadBusinessData();
    }
  }

  void _onBusinessChanged() {
    // Cada vez que el BusinessProvider notifique cambios, actualizar
    if (_businessProvider.business != null) {
      _populateFields();
      notifyListeners();
    }
  }

  Future<void> _loadBusinessData() async {
    _loading = true;
    notifyListeners();

    try {
      await _businessProvider.initialize();
      await _businessProvider.loadBusinessData();
      _error = null;
    } catch (e) {
      _error = 'Error al cargar datos: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void _populateFields() {
    final biz = _businessProvider.business;
    if (biz != null) {
      nameC.text = biz.name;
      addressC.text = biz.address ?? '';
      phoneC.text = biz.phone ?? '';
      initialCashC.text = biz.initialCash.toString();
      currencyC.text = biz.currency;
      taxC.text = biz.taxPercent.toString();
      selectedType.value = biz.type;
      logoC.value = biz.logo;
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
        initialCash: double.parse(initialCashC.text),
        taxPercent: double.parse(taxC.text),
        type: BusinessType.cafeteria,
        logo: logoC.value, enabledModules: [],
        address: addressC.text,
        phone: phoneC.text,
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
    // Remover listener
    _businessProvider.removeListener(_onBusinessChanged);

    nameC.dispose();
    addressC.dispose();
    phoneC.dispose();
    initialCashC.dispose();
    currencyC.dispose();
    taxC.dispose();
    logoC.dispose();
    selectedType.dispose();
    super.dispose();
  }
}
