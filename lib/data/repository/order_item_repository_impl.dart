import 'package:chicle_app_empleados/models/models.dart';
import 'package:hive/hive.dart';

import '../../domain/domain.dart';

class OrderItemRepositoryImp extends OrderItemRepository {
  static const _ORDER_ITEMS_BOX = Boxes.ordersItemBox;

  OrderItemRepositoryImp();

  Future<Box<OrderItemModel>> _openOrderItemsBox() async {
    if(Hive.isBoxOpen(_ORDER_ITEMS_BOX)) return await Hive.openBox<OrderItemModel>(_ORDER_ITEMS_BOX);
    return await Hive.openBox<OrderItemModel>(_ORDER_ITEMS_BOX);
  }

  @override
  Future<List<OrderItem>> getItemsByOrder(String idOrder) async {
    final box = await _openOrderItemsBox();
    List<OrderItem> orders = box.values.map((orderModel) => OrderItem.fromModel(orderModel)).toList();
    return orders;
  }

  @override
  Future<OrderItem?> getOrderItem(String id) async {
    final box = await _openOrderItemsBox();
    final orderItemModel = box.get(id);
    if (orderItemModel == null) return null;
    return OrderItem.fromModel(orderItemModel);
  }
}
