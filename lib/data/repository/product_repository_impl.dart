import 'package:chicle_app_empleados/models/models.dart';
import 'package:hive/hive.dart';

import '../../domain/domain.dart';

class ProductRepositoryImpl extends ProductRepository {
  static const _PRODUCT_BOX = Boxes.productsBox;

  ProductRepositoryImpl();

  Future<Box<ProductModel>> _openProductBox() async {
    if(Hive.isBoxOpen(_PRODUCT_BOX)) return await Hive.openBox<ProductModel>(_PRODUCT_BOX);
    return await Hive.openBox<ProductModel>(_PRODUCT_BOX);
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final box = await _openProductBox();
    List<Product> products = box.values.map((productModel) => Product.fromModel(productModel)).toList();
    return products;
  }

  @override
  Future<Product?> getProduct(String id) async {
    final box = await _openProductBox();
    final productModel = box.get(id);
    if (productModel == null) return null;
    return Product.fromModel(productModel);
  }

  @override
  Future<bool> saveProduct(Product product) async {
    return await _save(product);
  }

  @override
  Future<bool> updateProduct(String id, Product product) async {
    final exist = await getProduct(id);
    if(exist == null) throw Exception('La orden con id $id no existe');

    return _save(Product.withAll(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      category: product.category,
      imageUrl: product.imageUrl,
    ));
  }

  @override
  Future<bool> deleteProduct(String id) async {
    final box =  await _openProductBox();
    final exist = await getProduct(id);
    if(exist == null) throw Exception('La orden con id $id no existe');

    await box.delete(id);
    return true;
  }
  Future<void> close() async {
    if (Hive.isBoxOpen(_PRODUCT_BOX)) {
      final box = Hive.box<OrderModel>(_PRODUCT_BOX);
      await box.close();
    }
  }
  Future<void> clearAllData() async {
    final orderBox = await _openProductBox();
    await orderBox.clear();
  }

  Future<bool> _save(Product product) async {
    final box = await _openProductBox();
    final exists = await getProduct(product.id);
    if (exists == null) return false;

    final model = product.parseToModel();
    
    await box.put(product.id, model);
    return true;
  }
}
