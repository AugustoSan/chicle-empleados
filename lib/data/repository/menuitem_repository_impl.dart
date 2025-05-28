import '../../data/local/app_database.dart';
import '../../domain/domain.dart';

class MenuItemRepositoryImpl extends MenuItemRepository {
  final AppDatabase _db;

  MenuItemRepositoryImpl(this._db);

  /// Mapea de la fila de la BD a la entidad de dominio
  MenuItem _fromRow(MenuItemModelData row) => MenuItem(
    id:          row.id,
    name:        row.name,
    price:       row.price,
    category:    EnumMenuItemCategory.values[row.category],
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
  Future<int> saveMenuItem(MenuItem menuItem) async {
    final table = _db.menuItemModel;

    // Construye el companion SIN especificar `id`
    final companion = MenuItemModelCompanion.insert(
      name:        menuItem.name,
      price:       menuItem.price,
      category:    EnumMenuItemCategory.values.indexOf(menuItem.category),
      description: menuItem.description ?? '',
      imageUrl:    menuItem.imageUrl ?? '',
    );

    if (menuItem.id == null || menuItem.id == 0) {
      // Esto retornará el nuevo ID asignado
      final newId = await _db.into(table).insert(companion);
      return newId;
    }
    return -1;
  }

  @override
  Future<int> updateMenuItem(int id, MenuItem menuItem) async {
    final table = _db.menuItemModel;
    final data = MenuItemModelData(
      id:          id, // aquí ya debe existir
      name:        menuItem.name,
      price:       menuItem.price,
      category:    EnumMenuItemCategory.values.indexOf(menuItem.category),
      description: menuItem.description ?? '',
      imageUrl:    menuItem.imageUrl ?? '',
    );
    // write devuelve Future<int> con el número de filas modificadas
    final count = await (_db.update(table)
          ..where((tbl) => tbl.id.equals(id)))
        .write(data);
    return count;
  }

  @override
  Future<int> deleteMenuItem(int id) async {
    // Borrado con `go()` al final
    final res = await (_db.delete(_db.menuItemModel)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
    return res;
  }
}
