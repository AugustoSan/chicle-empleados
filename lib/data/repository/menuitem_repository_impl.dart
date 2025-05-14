import '../../data/local/app_database.dart';
import '../../domain/repositories/menuitem_repository.dart';
import '../../domain/entities/menuItem.dart';

class MenuItemRepositoryImpl extends MenuItemRepository {
  final AppDatabase _db;

  MenuItemRepositoryImpl(this._db);

  /// Mapea de la fila de la BD a la entidad de dominio
  MenuItem _fromRow(MenuItemModelData row) => MenuItem(
    id:          row.id,
    name:        row.name,
    price:       row.price,
    category:    row.category,
    description: row.description,
    imageUrl:    row.imageUrl,
  );

  @override
  Future<List<MenuItem>> getMenuItems() async {
    final rows = await _db.select(_db.menuItemModel).get();
    return rows.map(_fromRow).toList();
  }

  @override
  Future<MenuItem?> getMenuItem(int id) async {
    final row = await (_db.select(_db.menuItemModel)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _fromRow(row);
  }

  @override
  Future<void> saveMenuItem(MenuItem menuItem) async {
    final table = _db.menuItemModel;

    // Crea el objeto DataClass a partir del dominio
    final data = MenuItemModelData(
      id:          menuItem.id ?? 0, // id obligatorio en DataClass, pero sólo se usará en replace
      name:        menuItem.name,
      price:       menuItem.price,
      category:    menuItem.category,
      description: menuItem.description ?? '',
      imageUrl:    menuItem.imageUrl ?? '',
    );

    if (menuItem.id == null) {
      // Inserción: omitimos el id (se ignora el campo en la DataClass)
      await _db.into(table).insert(data);
    } else {
      // Actualización: filtramos por id y reemplazamos toda la fila
      await (_db.update(table)
            ..where((tbl) => tbl.id.equals(menuItem.id!)))
          .replace(data);
    }
  }

  @override
  Future<void> updateMenuItem(MenuItem menuItem) async {
    final table = _db.menuItemModel;
    final data = MenuItemModelData(
      id:          menuItem.id!, // aquí ya debe existir
      name:        menuItem.name,
      price:       menuItem.price,
      category:    menuItem.category,
      description: menuItem.description ?? '',
      imageUrl:    menuItem.imageUrl ?? '',
    );
    await (_db.update(table)
          ..where((tbl) => tbl.id.equals(menuItem.id!)))
        .replace(data);
  }

  @override
  Future<void> deleteMenuItem(int id) async {
    // Borrado con `go()` al final
    await (_db.delete(_db.menuItemModel)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
