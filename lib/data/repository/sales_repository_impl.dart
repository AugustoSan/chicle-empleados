import 'package:chicle_app_empleados/data/data.dart';

import '../../domain/domain.dart';

class SalesRepositoryImpl extends SalesRepository {
  final AppDatabase _db;

  SalesRepositoryImpl(this._db);

  @override
  Future<List<Sales>> getSales() async {
    final salesList = await _db.select(_db.salesModel).get();
    
    if(salesList.isEmpty) return [];

    final futures = salesList.map((item) async {
      final items = await getSaleItems(item.id);
      return Sales.withAll(
        id: item.id,
        status: EnumSalesStatus.values[item.status],
        date: item.date,
        customer: item.customer,
        items: items,
        userId: item.userId,
      );
    }).toList();

    return await Future.wait(futures);
  }

  @override
  Future<Sales?> getSale(int id) async {
    final sale = await (_db.select(_db.salesModel)
      ..where((tbl) => tbl.id.equals(id)))
      .getSingleOrNull();
    return sale == null ? null : Sales.withAll(
      id: id,
      status: EnumSalesStatus.values[sale.status],
      date: sale.date,
      customer: sale.customer,
      items: await getSaleItems(id),
      userId: sale.userId,
    );
  }

  @override
  Future<int> saveSale(Sales sales) async {
    final validate = await validateItemsExist(sales.items);
    if(validate.isNotEmpty) throw Exception(validate);

    final companion = SalesModelCompanion.insert(
      status: EnumSalesStatus.values.indexOf(sales.status),
      date: sales.date,
      userId: sales.userId,
      customer: sales.customer,
      total: sales.total,
    );
    
    // Ejecutamos el insert y recogemos el ID asignado
    final newId = await _db.into(_db.salesModel).insert(companion);

    if(newId > 0){
      await saveSalesMenuItems(newId, sales.items);
    }

    return newId;
  }

  @override
  Future<int> updateSale(int id, Sales sales) async {
    final validate = await validateItemsExist(sales.items);
    if(validate.isNotEmpty) throw Exception(validate);

    final companion = SalesModelCompanion.insert(
      status: EnumSalesStatus.values.indexOf(sales.status),
      date: sales.date,
      userId: sales.userId,
      customer: sales.customer,
      total: sales.total,
    );
    
    // Ejecutamos el update y recogemos cuántas filas se vieron afectadas
    final rowsAffected = await (_db.update(_db.salesModel)
      ..where((tbl) => tbl.id.equals(id))
    ).write(companion);

    await clearSaleItemsBySaleId(id);
    await saveSalesMenuItems(id, sales.items);

    // Devolvemos true si al menos una fila fue actualizada
    return rowsAffected > 0 ? 1 : 0;
  }

  @override
  Future<int> deleteSale(int id) async {
    // Borrado con `go()` al final
    final res = await (_db.delete(_db.salesModel)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
    return res;
  }

  Future<List<SaleItemMenu>> getSaleItems(int salesId) async {
    final rows = await (_db.select(_db.saleItemsModel)
      ..where((tbl) => tbl.saleId.equals(salesId)))
      .get();
    
    if (rows.isEmpty) return [];

    final futures = rows.map((item) async {
      final menuItem = await (_db.select(_db.menuItemModel)
        ..where((tbl) => tbl.id.equals(item.menuItemId)))
        .getSingle();
      return SaleItemMenu(
        menuItem: MenuItem.withAll(
          id: menuItem.id,
          name: menuItem.name,
          description: menuItem.description,
          price: menuItem.price,
          category: EnumMenuItemCategory.values[menuItem.category],
          imageUrl: menuItem.imageUrl,
        ),
        quantity: item.quantity,
        specialIndications: item.specialIndications,
      );
    }).toList();

    return await Future.wait(futures);
  }

  Future<int> saveSalesMenuItems(int salesId, List<SaleItemMenu> items) async {
    final newItemSales = items.map((item) async {
        final companion = SaleItemsModelCompanion.insert(
          saleId: salesId,
          menuItemId: item.menuItem.id!,
          quantity: item.quantity,
          subtotal: item.total,
          specialIndications: item.specialIndications,
        );
        return await _db.into(_db.saleItemsModel).insert(companion);
      }).toList();
    final result = await Future.wait(newItemSales);
    return result.length;
  }

  Future<int> clearSaleItemsBySaleId(int saleId) {
    return (_db.delete(_db.saleItemsModel)
        ..where((t) => t.saleId.equals(saleId)))
      .go(); // devuelve el número de filas borradas
  }

  Future<MenuItem?> _getMenuItem(int id) async {
    final row = await (_db.select(_db.menuItemModel)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : MenuItem.withAll(
      id: row.id,
      name: row.name,
      description: row.description,
      price: row.price,
      category: EnumMenuItemCategory.values[row.category],
      imageUrl: row.imageUrl,
    );
  }

  Future<String> validateItemsExist(List<SaleItemMenu> items) async {
    for (var item in items) {
      final menuItem = await _getMenuItem(item.menuItem.id ?? -1);
      if (menuItem == null) return 'El id ${item.menuItem.id} no existe';
    }
    return '';
  }
}
