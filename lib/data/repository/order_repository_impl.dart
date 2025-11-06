import 'package:chicle_app_empleados/models/models.dart';
import 'package:hive/hive.dart';

import '../../domain/domain.dart';

class OrderRepositoryImpl extends OrderRepository {
  static const _ORDER_BOX = Boxes.ordersBox;
  static const _ORDER_ITEMS_BOX = Boxes.ordersItemBox;

  OrderRepositoryImpl();

  Future<Box<OrderModel>> _openOrderBox() async {
    if(Hive.isBoxOpen(_ORDER_BOX)) return await Hive.openBox<OrderModel>(_ORDER_BOX);
    return await Hive.openBox<OrderModel>(_ORDER_BOX);
  }

  Future<Box<OrderItemModel>> _openOrderItemsBox() async {
    if(Hive.isBoxOpen(_ORDER_ITEMS_BOX)) return await Hive.openBox<OrderItemModel>(_ORDER_ITEMS_BOX);
    return await Hive.openBox<OrderItemModel>(_ORDER_ITEMS_BOX);
  }

  @override
  Future<List<Order>> getAllOrders() async {
    final box = await _openOrderBox();
    List<Order> orders = box.values.map((orderModel) => Order.fromModel(orderModel)).toList();
    return orders;
  }

  @override
  Future<Order?> getOrder(String id) async {
    final box = await _openOrderBox();
    final orderModel = box.get(id);
    if (orderModel == null) return null;
    return Order.fromModel(orderModel);
  }

  @override
  Future<bool> saveOrder(Order order) async {
    return await _save(order);
  }

  @override
  Future<bool> updateOrder(String id, Order order) async {
    final exist = await getOrder(id);
    if(exist == null) throw Exception('La orden con id $id no existe');

    return _updateOrder(id,Order.withAll(
      id: id,
      userId: order.userId,
      customer: order.customer,
      status: order.status,
      date: order.date,
      statusCashCut: order.statusCashCut,
      items: order.items,
    ));
  }

  @override
  Future<bool> deleteOrder(String id) async {
    final box =  await _openOrderBox();
    final exist = await getOrder(id);
    if(exist == null) throw Exception('La orden con id $id no existe');

    await box.delete(id);
    return true;
  }
  Future<void> close() async {
    if (Hive.isBoxOpen(_ORDER_BOX)) {
      final box = Hive.box<OrderModel>(_ORDER_BOX);
      await box.close();
    }
    if (Hive.isBoxOpen(_ORDER_ITEMS_BOX)) {
      final box = Hive.box<OrderItemModel>(_ORDER_ITEMS_BOX);
      await box.close();
    }
  }
  Future<void> clearAllData() async {
    final orderBox = await _openOrderBox();
    final orderItemsBox = await _openOrderItemsBox();
    await orderBox.clear();
    await orderItemsBox.clear();
  }

  Future<bool> _save(Order order) async {
    final box = await _openOrderBox();
    final exists = await getOrder(order.id);
    if (exists != null) return false;

    final model = order.parseToModel();
    
    await box.put(order.id, model);
    return true;
  }
  Future<bool> _updateOrder(String id, Order order) async {
    final box = await _openOrderBox();
    final exists = await getOrder(id);
    if (exists == null) return false;

    final model = order.parseToModel();
    
    await box.put(order.id, model);
    return true;
  }
}
