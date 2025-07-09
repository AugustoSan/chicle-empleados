import '../domain.dart';

import '../enums/enums.dart';

class Sales {
  late int?      id;          // Nullable porque la BD lo asigna
  late EnumSalesStatus   status;
  late DateTime  date;  // Opcional
  final int  userId;     // Usuario que realizo la venta
  final String  consumer;
  late List<SaleItemMenu> items;

  Sales({
    this.id,
    required this.userId,
    required this.consumer,
    required this.items,
  })
  {
    date = DateTime.now();
    status = EnumSalesStatus.pending;
  }
  Sales.withDate({
    this.id,
    required this.userId,
    required this.consumer,
    required this.date,
    required this.items,
  })
  {
    status = EnumSalesStatus.pending;
  }

  Sales.withoutItems({
    this.id,
    required this.userId,
    required this.consumer,
    required this.date,
    required this.status,
  })
  {
    items = [];
  }

  Sales.withoutId({
    required this.userId,
    required this.consumer,
    required this.status,
    required this.date,
    required this.items,
  })
  {
    id = -1;
  }

  Sales.withAll({
    required this.id,
    required this.status,
    required this.date,
    required this.items,
    required this.userId,
    required this.consumer,
  });
  double  get total => items.fold(0.0, (sum, item) => sum + item.total);
}

class SaleItemMenu {
  final MenuItem menuItem;
  final int quantity;
  final String specialIndications;
  
  SaleItemMenu({
    required this.menuItem,
    required this.quantity,
    required this.specialIndications,
  });
  double  get total => menuItem.price * quantity;
}