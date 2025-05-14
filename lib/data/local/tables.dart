import 'package:drift/drift.dart';

class UsersModel extends Table {
  IntColumn    get id       => integer().autoIncrement()();
  TextColumn   get name     => text()();
  TextColumn   get email    => text().customConstraint('NOT NULL UNIQUE')();
  TextColumn   get password => text()();
}

class MenuItemModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  TextColumn get category => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
}

// class SalesModel extends Table {
//   IntColumn     get id        => integer().autoIncrement()();
//   DateTimeColumn get date     => dateTime()();
//   RealColumn    get total     => real()();
// }

// class SaleItemsModel extends Table {
//   IntColumn  get id        => integer().autoIncrement()();
//   IntColumn  get saleId    => integer().customConstraint('REFERENCES sales(id)')();
//   IntColumn  get productId => integer().customConstraint('REFERENCES products(id)')();
//   IntColumn  get quantity  => integer()();
//   RealColumn get subtotal  => real()();
// }
