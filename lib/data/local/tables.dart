import 'package:drift/drift.dart';

class UsersModel extends Table {
  IntColumn    get id       => integer().autoIncrement()();
  TextColumn   get name     => text()();
  TextColumn   get username    => text().customConstraint('NOT NULL UNIQUE')();
  TextColumn   get password => text()();
  TextColumn   get imageUrl => text()();
}

class MenuItemModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  IntColumn get category => integer()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
}

class SalesModel extends Table {
  IntColumn      get id        => integer().autoIncrement()();
  DateTimeColumn get date      => dateTime()();
  RealColumn     get subTotal  => real()();
  RealColumn     get total     => real()();
  IntColumn      get userId    => integer().references(UsersModel, #id)();
}

class SaleItemsModel extends Table {
  IntColumn  get id          => integer().autoIncrement()();
  IntColumn  get saleId      => integer().references(SalesModel, #id)();
  IntColumn  get menuItemId  => integer().references(MenuItemModel, #id)();
  TextColumn get specialIndications => text()();
  IntColumn  get quantity    => integer()();
  RealColumn get subtotal    => real()();
}
