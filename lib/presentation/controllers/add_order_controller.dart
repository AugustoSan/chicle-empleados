import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class AddOrderController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  // final ValueNotifier<Customer?> customer = ValueNotifier<Customer?>(null);

  bool  _loading = false;
  String? _error;

  bool  get loading => _loading;
  String? get error => _error;

  List<Product> _listProducts = [];
  Map<Product,OrderItem> _orderItems = {};
  
  set orderItems(Map<Product,OrderItem> value) {
    _orderItems = value;
    notifyListeners();
  }

  Map<Product,OrderItem> get orderItems => _orderItems;
  List<Product> get listProducts => _listProducts;


  final OrderRepository _orderRepository;
  final UserProvider _userProvider;
  final ProductProvider _productProvider;


  AddOrderController(this._orderRepository, this._userProvider, this._productProvider){
    initForm();
  }

  void initForm() async {
    await _productProvider.loadAll();
    final products = _productProvider.allItems;
    final Map<Product, OrderItem> map = {};
    for (var item in products) {
      map[item] = OrderItem.fromProduct(item);
    }
    _listProducts.clear();
    _listProducts.addAll(products);
    _orderItems.clear();
    _orderItems.addEntries(map.entries);
    notifyListeners();
  }
  
  Future<String> saveSale(BuildContext context, List<OrderItem> items) async {
    _loading = true;
    _error   = null;
    notifyListeners();

    final user = await _userProvider.getCurrentUser();
    if (user == null) {
      _error = 'Usuario no encontrado';
      return _error!;
    }

    final res = await _orderRepository.saveOrder(
      Order.withoutId(
        userId: user.id, 
        customer: nameC.text == '' ? 'Público en general' : nameC.text, 
        status: EnumOrderStatus.pending, 
        date: DateTime.now(), 
        items: items
      )
    );
    if(!res) {
      _error = 'Ocurrio un error al guardar';
      return _error!;
    }
    _loading = false;
    initForm();
    notifyListeners();
    return _error ?? '';
  }

  @override
  void dispose() {
    nameC.dispose();
    super.dispose();
  }
}
