import 'package:chicle_app_empleados/models/models.dart';
import 'package:uuid/uuid.dart';

import '../domain.dart';

class Order {
  final String      id;          // Nullable porque la BD lo asigna
  late EnumOrderStatus   status;
  late DateTime  date;  // Opcional
  final String  userId;     // Usuario que realizo la venta
  final String  customer;
  late List<OrderItem> items;

  Order({
    required this.id,
    required this.userId,
    required this.customer,
    required this.items,
  })
  {
    date = DateTime.now();
    status = EnumOrderStatus.pending;
  }
  Order.withDate({
    String? id,
    required this.userId,
    required this.customer,
    required this.date,
    required this.items,
  }) : this.id = id ?? const Uuid().v4()
  {
    status = EnumOrderStatus.pending;
  }

  Order.withoutItems({
    String? id,
    required this.userId,
    required this.customer,
    required this.date,
    required this.status,
  }) : this.id = id ?? const Uuid().v4()
  {
    items = [];
  }

  Order.withoutId({
    required this.userId,
    required this.customer,
    required this.status,
    required this.date,
    required this.items,
  }) : this.id = const Uuid().v4();

  Order.withAll({
    required this.id,
    required this.status,
    required this.date,
    required this.items,
    required this.userId,
    required this.customer,
  });

  Order.fromModel(OrderModel model) :
    id = model.id,
    userId = model.userId,
    customer = model.customer,
    status = EnumOrderStatus.values[model.status],
    date = model.date,
    items = model.items.map((itemModel) => OrderItem.fromModel(itemModel)).toList();


  OrderModel parseToModel() => OrderModel(
    id: id,
    userId: userId,
    customer: customer,
    status: status.index,
    date: date,
    items: items.map((item) => item.parseToModel()).toList(),
  );
  double  get total => items.fold(0.0, (sum, item) => sum + (item.quantity * item.priceAtOrder));
}

class OrderItem {
  final String id;
  final String orderId;
  final Product product;
  late int quantity;
  final double priceAtOrder;
  late String? specialIndications;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.product,
    required this.quantity,
    required this.priceAtOrder,
    this.specialIndications,
  });
  OrderItem.withoutId({
    required this.orderId,
    required this.product,
    required this.quantity,
    required this.priceAtOrder,
    this.specialIndications,
  }) : this.id = const Uuid().v4();
  OrderItem.withoutIds({
    required this.product,
    required this.quantity,
    required this.priceAtOrder,
    this.specialIndications,
  }) : this.id = const Uuid().v4(),
        orderId = const Uuid().v4();

  OrderItem.fromProduct(Product _product) : 
    id = const Uuid().v4(),
    orderId = const Uuid().v4(),
    product = _product,
    quantity = 0,
    priceAtOrder = _product.price,
    specialIndications = '';

  OrderItem.fromModel(OrderItemModel model) :
    id = model.id,
    orderId = model.orderId,
    product = Product.fromModel(model.product),
    quantity = model.quantity,
    priceAtOrder = model.priceAtOrder,
    specialIndications = model.specialIndications;

  OrderItemModel parseToModel() => OrderItemModel(
    id: id,
    orderId: orderId,
    product: product.parseToModel(),
    quantity: quantity,
    priceAtOrder: priceAtOrder,
    specialIndications: specialIndications,
  );

  double get total => quantity * priceAtOrder;
}