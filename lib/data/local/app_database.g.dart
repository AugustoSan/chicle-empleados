// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersModelTable extends UsersModel
    with TableInfo<$UsersModelTable, UsersModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, username];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users_model';
  @override
  VerificationContext validateIntegrity(Insertable<UsersModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersModelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
    );
  }

  @override
  $UsersModelTable createAlias(String alias) {
    return $UsersModelTable(attachedDatabase, alias);
  }
}

class UsersModelData extends DataClass implements Insertable<UsersModelData> {
  final int id;
  final String username;
  const UsersModelData({required this.id, required this.username});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    return map;
  }

  UsersModelCompanion toCompanion(bool nullToAbsent) {
    return UsersModelCompanion(
      id: Value(id),
      username: Value(username),
    );
  }

  factory UsersModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersModelData(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
    };
  }

  UsersModelData copyWith({int? id, String? username}) => UsersModelData(
        id: id ?? this.id,
        username: username ?? this.username,
      );
  UsersModelData copyWithCompanion(UsersModelCompanion data) {
    return UsersModelData(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsersModelData(')
          ..write('id: $id, ')
          ..write('username: $username')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersModelData &&
          other.id == this.id &&
          other.username == this.username);
}

class UsersModelCompanion extends UpdateCompanion<UsersModelData> {
  final Value<int> id;
  final Value<String> username;
  const UsersModelCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
  });
  UsersModelCompanion.insert({
    this.id = const Value.absent(),
    required String username,
  }) : username = Value(username);
  static Insertable<UsersModelData> custom({
    Expression<int>? id,
    Expression<String>? username,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
    });
  }

  UsersModelCompanion copyWith({Value<int>? id, Value<String>? username}) {
    return UsersModelCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersModelCompanion(')
          ..write('id: $id, ')
          ..write('username: $username')
          ..write(')'))
        .toString();
  }
}

class $MenuItemModelTable extends MenuItemModel
    with TableInfo<$MenuItemModelTable, MenuItemModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuItemModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
      'category', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, price, category, description, image];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_item_model';
  @override
  VerificationContext validateIntegrity(Insertable<MenuItemModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenuItemModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuItemModelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
    );
  }

  @override
  $MenuItemModelTable createAlias(String alias) {
    return $MenuItemModelTable(attachedDatabase, alias);
  }
}

class MenuItemModelData extends DataClass
    implements Insertable<MenuItemModelData> {
  final int id;
  final String name;
  final double price;
  final int category;
  final String description;
  final String image;
  const MenuItemModelData(
      {required this.id,
      required this.name,
      required this.price,
      required this.category,
      required this.description,
      required this.image});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<double>(price);
    map['category'] = Variable<int>(category);
    map['description'] = Variable<String>(description);
    map['image'] = Variable<String>(image);
    return map;
  }

  MenuItemModelCompanion toCompanion(bool nullToAbsent) {
    return MenuItemModelCompanion(
      id: Value(id),
      name: Value(name),
      price: Value(price),
      category: Value(category),
      description: Value(description),
      image: Value(image),
    );
  }

  factory MenuItemModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuItemModelData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      category: serializer.fromJson<int>(json['category']),
      description: serializer.fromJson<String>(json['description']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'category': serializer.toJson<int>(category),
      'description': serializer.toJson<String>(description),
      'image': serializer.toJson<String>(image),
    };
  }

  MenuItemModelData copyWith(
          {int? id,
          String? name,
          double? price,
          int? category,
          String? description,
          String? image}) =>
      MenuItemModelData(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        category: category ?? this.category,
        description: description ?? this.description,
        image: image ?? this.image,
      );
  MenuItemModelData copyWithCompanion(MenuItemModelCompanion data) {
    return MenuItemModelData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      price: data.price.present ? data.price.value : this.price,
      category: data.category.present ? data.category.value : this.category,
      description:
          data.description.present ? data.description.value : this.description,
      image: data.image.present ? data.image.value : this.image,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuItemModelData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, price, category, description, image);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuItemModelData &&
          other.id == this.id &&
          other.name == this.name &&
          other.price == this.price &&
          other.category == this.category &&
          other.description == this.description &&
          other.image == this.image);
}

class MenuItemModelCompanion extends UpdateCompanion<MenuItemModelData> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> price;
  final Value<int> category;
  final Value<String> description;
  final Value<String> image;
  const MenuItemModelCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.image = const Value.absent(),
  });
  MenuItemModelCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double price,
    required int category,
    required String description,
    required String image,
  })  : name = Value(name),
        price = Value(price),
        category = Value(category),
        description = Value(description),
        image = Value(image);
  static Insertable<MenuItemModelData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? price,
    Expression<int>? category,
    Expression<String>? description,
    Expression<String>? image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (image != null) 'image': image,
    });
  }

  MenuItemModelCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<double>? price,
      Value<int>? category,
      Value<String>? description,
      Value<String>? image}) {
    return MenuItemModelCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenuItemModelCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $SalesModelTable extends SalesModel
    with TableInfo<$SalesModelTable, SalesModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users_model (id)'));
  static const VerificationMeta _customerMeta =
      const VerificationMeta('customer');
  @override
  late final GeneratedColumn<String> customer = GeneratedColumn<String>(
      'customer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, status, date, total, userId, customer];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_model';
  @override
  VerificationContext validateIntegrity(Insertable<SalesModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('customer')) {
      context.handle(_customerMeta,
          customer.isAcceptableOrUnknown(data['customer']!, _customerMeta));
    } else if (isInserting) {
      context.missing(_customerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesModelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      customer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer'])!,
    );
  }

  @override
  $SalesModelTable createAlias(String alias) {
    return $SalesModelTable(attachedDatabase, alias);
  }
}

class SalesModelData extends DataClass implements Insertable<SalesModelData> {
  final int id;
  final int status;
  final DateTime date;
  final double total;
  final int userId;
  final String customer;
  const SalesModelData(
      {required this.id,
      required this.status,
      required this.date,
      required this.total,
      required this.userId,
      required this.customer});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['status'] = Variable<int>(status);
    map['date'] = Variable<DateTime>(date);
    map['total'] = Variable<double>(total);
    map['user_id'] = Variable<int>(userId);
    map['customer'] = Variable<String>(customer);
    return map;
  }

  SalesModelCompanion toCompanion(bool nullToAbsent) {
    return SalesModelCompanion(
      id: Value(id),
      status: Value(status),
      date: Value(date),
      total: Value(total),
      userId: Value(userId),
      customer: Value(customer),
    );
  }

  factory SalesModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesModelData(
      id: serializer.fromJson<int>(json['id']),
      status: serializer.fromJson<int>(json['status']),
      date: serializer.fromJson<DateTime>(json['date']),
      total: serializer.fromJson<double>(json['total']),
      userId: serializer.fromJson<int>(json['userId']),
      customer: serializer.fromJson<String>(json['customer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'status': serializer.toJson<int>(status),
      'date': serializer.toJson<DateTime>(date),
      'total': serializer.toJson<double>(total),
      'userId': serializer.toJson<int>(userId),
      'customer': serializer.toJson<String>(customer),
    };
  }

  SalesModelData copyWith(
          {int? id,
          int? status,
          DateTime? date,
          double? total,
          int? userId,
          String? customer}) =>
      SalesModelData(
        id: id ?? this.id,
        status: status ?? this.status,
        date: date ?? this.date,
        total: total ?? this.total,
        userId: userId ?? this.userId,
        customer: customer ?? this.customer,
      );
  SalesModelData copyWithCompanion(SalesModelCompanion data) {
    return SalesModelData(
      id: data.id.present ? data.id.value : this.id,
      status: data.status.present ? data.status.value : this.status,
      date: data.date.present ? data.date.value : this.date,
      total: data.total.present ? data.total.value : this.total,
      userId: data.userId.present ? data.userId.value : this.userId,
      customer: data.customer.present ? data.customer.value : this.customer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesModelData(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('date: $date, ')
          ..write('total: $total, ')
          ..write('userId: $userId, ')
          ..write('customer: $customer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, status, date, total, userId, customer);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesModelData &&
          other.id == this.id &&
          other.status == this.status &&
          other.date == this.date &&
          other.total == this.total &&
          other.userId == this.userId &&
          other.customer == this.customer);
}

class SalesModelCompanion extends UpdateCompanion<SalesModelData> {
  final Value<int> id;
  final Value<int> status;
  final Value<DateTime> date;
  final Value<double> total;
  final Value<int> userId;
  final Value<String> customer;
  const SalesModelCompanion({
    this.id = const Value.absent(),
    this.status = const Value.absent(),
    this.date = const Value.absent(),
    this.total = const Value.absent(),
    this.userId = const Value.absent(),
    this.customer = const Value.absent(),
  });
  SalesModelCompanion.insert({
    this.id = const Value.absent(),
    required int status,
    required DateTime date,
    required double total,
    required int userId,
    required String customer,
  })  : status = Value(status),
        date = Value(date),
        total = Value(total),
        userId = Value(userId),
        customer = Value(customer);
  static Insertable<SalesModelData> custom({
    Expression<int>? id,
    Expression<int>? status,
    Expression<DateTime>? date,
    Expression<double>? total,
    Expression<int>? userId,
    Expression<String>? customer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (date != null) 'date': date,
      if (total != null) 'total': total,
      if (userId != null) 'user_id': userId,
      if (customer != null) 'customer': customer,
    });
  }

  SalesModelCompanion copyWith(
      {Value<int>? id,
      Value<int>? status,
      Value<DateTime>? date,
      Value<double>? total,
      Value<int>? userId,
      Value<String>? customer}) {
    return SalesModelCompanion(
      id: id ?? this.id,
      status: status ?? this.status,
      date: date ?? this.date,
      total: total ?? this.total,
      userId: userId ?? this.userId,
      customer: customer ?? this.customer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (customer.present) {
      map['customer'] = Variable<String>(customer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesModelCompanion(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('date: $date, ')
          ..write('total: $total, ')
          ..write('userId: $userId, ')
          ..write('customer: $customer')
          ..write(')'))
        .toString();
  }
}

class $SaleItemsModelTable extends SaleItemsModel
    with TableInfo<$SaleItemsModelTable, SaleItemsModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleItemsModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<int> saleId = GeneratedColumn<int>(
      'sale_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sales_model (id)'));
  static const VerificationMeta _menuItemIdMeta =
      const VerificationMeta('menuItemId');
  @override
  late final GeneratedColumn<int> menuItemId = GeneratedColumn<int>(
      'menu_item_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES menu_item_model (id)'));
  static const VerificationMeta _specialIndicationsMeta =
      const VerificationMeta('specialIndications');
  @override
  late final GeneratedColumn<String> specialIndications =
      GeneratedColumn<String>('special_indications', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, saleId, menuItemId, specialIndications, quantity, subtotal];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_items_model';
  @override
  VerificationContext validateIntegrity(Insertable<SaleItemsModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sale_id')) {
      context.handle(_saleIdMeta,
          saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta));
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('menu_item_id')) {
      context.handle(
          _menuItemIdMeta,
          menuItemId.isAcceptableOrUnknown(
              data['menu_item_id']!, _menuItemIdMeta));
    } else if (isInserting) {
      context.missing(_menuItemIdMeta);
    }
    if (data.containsKey('special_indications')) {
      context.handle(
          _specialIndicationsMeta,
          specialIndications.isAcceptableOrUnknown(
              data['special_indications']!, _specialIndicationsMeta));
    } else if (isInserting) {
      context.missing(_specialIndicationsMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleItemsModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleItemsModelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      saleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sale_id'])!,
      menuItemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}menu_item_id'])!,
      specialIndications: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}special_indications'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
    );
  }

  @override
  $SaleItemsModelTable createAlias(String alias) {
    return $SaleItemsModelTable(attachedDatabase, alias);
  }
}

class SaleItemsModelData extends DataClass
    implements Insertable<SaleItemsModelData> {
  final int id;
  final int saleId;
  final int menuItemId;
  final String specialIndications;
  final int quantity;
  final double subtotal;
  const SaleItemsModelData(
      {required this.id,
      required this.saleId,
      required this.menuItemId,
      required this.specialIndications,
      required this.quantity,
      required this.subtotal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sale_id'] = Variable<int>(saleId);
    map['menu_item_id'] = Variable<int>(menuItemId);
    map['special_indications'] = Variable<String>(specialIndications);
    map['quantity'] = Variable<int>(quantity);
    map['subtotal'] = Variable<double>(subtotal);
    return map;
  }

  SaleItemsModelCompanion toCompanion(bool nullToAbsent) {
    return SaleItemsModelCompanion(
      id: Value(id),
      saleId: Value(saleId),
      menuItemId: Value(menuItemId),
      specialIndications: Value(specialIndications),
      quantity: Value(quantity),
      subtotal: Value(subtotal),
    );
  }

  factory SaleItemsModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleItemsModelData(
      id: serializer.fromJson<int>(json['id']),
      saleId: serializer.fromJson<int>(json['saleId']),
      menuItemId: serializer.fromJson<int>(json['menuItemId']),
      specialIndications:
          serializer.fromJson<String>(json['specialIndications']),
      quantity: serializer.fromJson<int>(json['quantity']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'saleId': serializer.toJson<int>(saleId),
      'menuItemId': serializer.toJson<int>(menuItemId),
      'specialIndications': serializer.toJson<String>(specialIndications),
      'quantity': serializer.toJson<int>(quantity),
      'subtotal': serializer.toJson<double>(subtotal),
    };
  }

  SaleItemsModelData copyWith(
          {int? id,
          int? saleId,
          int? menuItemId,
          String? specialIndications,
          int? quantity,
          double? subtotal}) =>
      SaleItemsModelData(
        id: id ?? this.id,
        saleId: saleId ?? this.saleId,
        menuItemId: menuItemId ?? this.menuItemId,
        specialIndications: specialIndications ?? this.specialIndications,
        quantity: quantity ?? this.quantity,
        subtotal: subtotal ?? this.subtotal,
      );
  SaleItemsModelData copyWithCompanion(SaleItemsModelCompanion data) {
    return SaleItemsModelData(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      menuItemId:
          data.menuItemId.present ? data.menuItemId.value : this.menuItemId,
      specialIndications: data.specialIndications.present
          ? data.specialIndications.value
          : this.specialIndications,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemsModelData(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('menuItemId: $menuItemId, ')
          ..write('specialIndications: $specialIndications, ')
          ..write('quantity: $quantity, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, saleId, menuItemId, specialIndications, quantity, subtotal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleItemsModelData &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.menuItemId == this.menuItemId &&
          other.specialIndications == this.specialIndications &&
          other.quantity == this.quantity &&
          other.subtotal == this.subtotal);
}

class SaleItemsModelCompanion extends UpdateCompanion<SaleItemsModelData> {
  final Value<int> id;
  final Value<int> saleId;
  final Value<int> menuItemId;
  final Value<String> specialIndications;
  final Value<int> quantity;
  final Value<double> subtotal;
  const SaleItemsModelCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.menuItemId = const Value.absent(),
    this.specialIndications = const Value.absent(),
    this.quantity = const Value.absent(),
    this.subtotal = const Value.absent(),
  });
  SaleItemsModelCompanion.insert({
    this.id = const Value.absent(),
    required int saleId,
    required int menuItemId,
    required String specialIndications,
    required int quantity,
    required double subtotal,
  })  : saleId = Value(saleId),
        menuItemId = Value(menuItemId),
        specialIndications = Value(specialIndications),
        quantity = Value(quantity),
        subtotal = Value(subtotal);
  static Insertable<SaleItemsModelData> custom({
    Expression<int>? id,
    Expression<int>? saleId,
    Expression<int>? menuItemId,
    Expression<String>? specialIndications,
    Expression<int>? quantity,
    Expression<double>? subtotal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (menuItemId != null) 'menu_item_id': menuItemId,
      if (specialIndications != null) 'special_indications': specialIndications,
      if (quantity != null) 'quantity': quantity,
      if (subtotal != null) 'subtotal': subtotal,
    });
  }

  SaleItemsModelCompanion copyWith(
      {Value<int>? id,
      Value<int>? saleId,
      Value<int>? menuItemId,
      Value<String>? specialIndications,
      Value<int>? quantity,
      Value<double>? subtotal}) {
    return SaleItemsModelCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      menuItemId: menuItemId ?? this.menuItemId,
      specialIndications: specialIndications ?? this.specialIndications,
      quantity: quantity ?? this.quantity,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<int>(saleId.value);
    }
    if (menuItemId.present) {
      map['menu_item_id'] = Variable<int>(menuItemId.value);
    }
    if (specialIndications.present) {
      map['special_indications'] = Variable<String>(specialIndications.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemsModelCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('menuItemId: $menuItemId, ')
          ..write('specialIndications: $specialIndications, ')
          ..write('quantity: $quantity, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersModelTable usersModel = $UsersModelTable(this);
  late final $MenuItemModelTable menuItemModel = $MenuItemModelTable(this);
  late final $SalesModelTable salesModel = $SalesModelTable(this);
  late final $SaleItemsModelTable saleItemsModel = $SaleItemsModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [usersModel, menuItemModel, salesModel, saleItemsModel];
}

typedef $$UsersModelTableCreateCompanionBuilder = UsersModelCompanion Function({
  Value<int> id,
  required String username,
});
typedef $$UsersModelTableUpdateCompanionBuilder = UsersModelCompanion Function({
  Value<int> id,
  Value<String> username,
});

final class $$UsersModelTableReferences
    extends BaseReferences<_$AppDatabase, $UsersModelTable, UsersModelData> {
  $$UsersModelTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SalesModelTable, List<SalesModelData>>
      _salesModelRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.salesModel,
              aliasName:
                  $_aliasNameGenerator(db.usersModel.id, db.salesModel.userId));

  $$SalesModelTableProcessedTableManager get salesModelRefs {
    final manager = $$SalesModelTableTableManager($_db, $_db.salesModel)
        .filter((f) => f.userId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_salesModelRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersModelTableFilterComposer
    extends Composer<_$AppDatabase, $UsersModelTable> {
  $$UsersModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  Expression<bool> salesModelRefs(
      Expression<bool> Function($$SalesModelTableFilterComposer f) f) {
    final $$SalesModelTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.salesModel,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SalesModelTableFilterComposer(
              $db: $db,
              $table: $db.salesModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersModelTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersModelTable> {
  $$UsersModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));
}

class $$UsersModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersModelTable> {
  $$UsersModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  Expression<T> salesModelRefs<T extends Object>(
      Expression<T> Function($$SalesModelTableAnnotationComposer a) f) {
    final $$SalesModelTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.salesModel,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SalesModelTableAnnotationComposer(
              $db: $db,
              $table: $db.salesModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersModelTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersModelTable,
    UsersModelData,
    $$UsersModelTableFilterComposer,
    $$UsersModelTableOrderingComposer,
    $$UsersModelTableAnnotationComposer,
    $$UsersModelTableCreateCompanionBuilder,
    $$UsersModelTableUpdateCompanionBuilder,
    (UsersModelData, $$UsersModelTableReferences),
    UsersModelData,
    PrefetchHooks Function({bool salesModelRefs})> {
  $$UsersModelTableTableManager(_$AppDatabase db, $UsersModelTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
          }) =>
              UsersModelCompanion(
            id: id,
            username: username,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String username,
          }) =>
              UsersModelCompanion.insert(
            id: id,
            username: username,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UsersModelTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({salesModelRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (salesModelRefs) db.salesModel],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (salesModelRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$UsersModelTableReferences
                            ._salesModelRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersModelTableReferences(db, table, p0)
                                .salesModelRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersModelTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersModelTable,
    UsersModelData,
    $$UsersModelTableFilterComposer,
    $$UsersModelTableOrderingComposer,
    $$UsersModelTableAnnotationComposer,
    $$UsersModelTableCreateCompanionBuilder,
    $$UsersModelTableUpdateCompanionBuilder,
    (UsersModelData, $$UsersModelTableReferences),
    UsersModelData,
    PrefetchHooks Function({bool salesModelRefs})>;
typedef $$MenuItemModelTableCreateCompanionBuilder = MenuItemModelCompanion
    Function({
  Value<int> id,
  required String name,
  required double price,
  required int category,
  required String description,
  required String image,
});
typedef $$MenuItemModelTableUpdateCompanionBuilder = MenuItemModelCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<double> price,
  Value<int> category,
  Value<String> description,
  Value<String> image,
});

final class $$MenuItemModelTableReferences extends BaseReferences<_$AppDatabase,
    $MenuItemModelTable, MenuItemModelData> {
  $$MenuItemModelTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SaleItemsModelTable, List<SaleItemsModelData>>
      _saleItemsModelRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.saleItemsModel,
              aliasName: $_aliasNameGenerator(
                  db.menuItemModel.id, db.saleItemsModel.menuItemId));

  $$SaleItemsModelTableProcessedTableManager get saleItemsModelRefs {
    final manager = $$SaleItemsModelTableTableManager($_db, $_db.saleItemsModel)
        .filter((f) => f.menuItemId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_saleItemsModelRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MenuItemModelTableFilterComposer
    extends Composer<_$AppDatabase, $MenuItemModelTable> {
  $$MenuItemModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));

  Expression<bool> saleItemsModelRefs(
      Expression<bool> Function($$SaleItemsModelTableFilterComposer f) f) {
    final $$SaleItemsModelTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.saleItemsModel,
        getReferencedColumn: (t) => t.menuItemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SaleItemsModelTableFilterComposer(
              $db: $db,
              $table: $db.saleItemsModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MenuItemModelTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuItemModelTable> {
  $$MenuItemModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));
}

class $$MenuItemModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuItemModelTable> {
  $$MenuItemModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  Expression<T> saleItemsModelRefs<T extends Object>(
      Expression<T> Function($$SaleItemsModelTableAnnotationComposer a) f) {
    final $$SaleItemsModelTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.saleItemsModel,
        getReferencedColumn: (t) => t.menuItemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SaleItemsModelTableAnnotationComposer(
              $db: $db,
              $table: $db.saleItemsModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MenuItemModelTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MenuItemModelTable,
    MenuItemModelData,
    $$MenuItemModelTableFilterComposer,
    $$MenuItemModelTableOrderingComposer,
    $$MenuItemModelTableAnnotationComposer,
    $$MenuItemModelTableCreateCompanionBuilder,
    $$MenuItemModelTableUpdateCompanionBuilder,
    (MenuItemModelData, $$MenuItemModelTableReferences),
    MenuItemModelData,
    PrefetchHooks Function({bool saleItemsModelRefs})> {
  $$MenuItemModelTableTableManager(_$AppDatabase db, $MenuItemModelTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuItemModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuItemModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuItemModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<int> category = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> image = const Value.absent(),
          }) =>
              MenuItemModelCompanion(
            id: id,
            name: name,
            price: price,
            category: category,
            description: description,
            image: image,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required double price,
            required int category,
            required String description,
            required String image,
          }) =>
              MenuItemModelCompanion.insert(
            id: id,
            name: name,
            price: price,
            category: category,
            description: description,
            image: image,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MenuItemModelTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({saleItemsModelRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (saleItemsModelRefs) db.saleItemsModel
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (saleItemsModelRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$MenuItemModelTableReferences
                            ._saleItemsModelRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MenuItemModelTableReferences(db, table, p0)
                                .saleItemsModelRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.menuItemId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MenuItemModelTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MenuItemModelTable,
    MenuItemModelData,
    $$MenuItemModelTableFilterComposer,
    $$MenuItemModelTableOrderingComposer,
    $$MenuItemModelTableAnnotationComposer,
    $$MenuItemModelTableCreateCompanionBuilder,
    $$MenuItemModelTableUpdateCompanionBuilder,
    (MenuItemModelData, $$MenuItemModelTableReferences),
    MenuItemModelData,
    PrefetchHooks Function({bool saleItemsModelRefs})>;
typedef $$SalesModelTableCreateCompanionBuilder = SalesModelCompanion Function({
  Value<int> id,
  required int status,
  required DateTime date,
  required double total,
  required int userId,
  required String customer,
});
typedef $$SalesModelTableUpdateCompanionBuilder = SalesModelCompanion Function({
  Value<int> id,
  Value<int> status,
  Value<DateTime> date,
  Value<double> total,
  Value<int> userId,
  Value<String> customer,
});

final class $$SalesModelTableReferences
    extends BaseReferences<_$AppDatabase, $SalesModelTable, SalesModelData> {
  $$SalesModelTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersModelTable _userIdTable(_$AppDatabase db) =>
      db.usersModel.createAlias(
          $_aliasNameGenerator(db.salesModel.userId, db.usersModel.id));

  $$UsersModelTableProcessedTableManager? get userId {
    if ($_item.userId == null) return null;
    final manager = $$UsersModelTableTableManager($_db, $_db.usersModel)
        .filter((f) => f.id($_item.userId!));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SaleItemsModelTable, List<SaleItemsModelData>>
      _saleItemsModelRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.saleItemsModel,
              aliasName: $_aliasNameGenerator(
                  db.salesModel.id, db.saleItemsModel.saleId));

  $$SaleItemsModelTableProcessedTableManager get saleItemsModelRefs {
    final manager = $$SaleItemsModelTableTableManager($_db, $_db.saleItemsModel)
        .filter((f) => f.saleId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_saleItemsModelRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SalesModelTableFilterComposer
    extends Composer<_$AppDatabase, $SalesModelTable> {
  $$SalesModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customer => $composableBuilder(
      column: $table.customer, builder: (column) => ColumnFilters(column));

  $$UsersModelTableFilterComposer get userId {
    final $$UsersModelTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.usersModel,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersModelTableFilterComposer(
              $db: $db,
              $table: $db.usersModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> saleItemsModelRefs(
      Expression<bool> Function($$SaleItemsModelTableFilterComposer f) f) {
    final $$SaleItemsModelTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.saleItemsModel,
        getReferencedColumn: (t) => t.saleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SaleItemsModelTableFilterComposer(
              $db: $db,
              $table: $db.saleItemsModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SalesModelTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesModelTable> {
  $$SalesModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customer => $composableBuilder(
      column: $table.customer, builder: (column) => ColumnOrderings(column));

  $$UsersModelTableOrderingComposer get userId {
    final $$UsersModelTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.usersModel,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersModelTableOrderingComposer(
              $db: $db,
              $table: $db.usersModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SalesModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesModelTable> {
  $$SalesModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get customer =>
      $composableBuilder(column: $table.customer, builder: (column) => column);

  $$UsersModelTableAnnotationComposer get userId {
    final $$UsersModelTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.usersModel,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersModelTableAnnotationComposer(
              $db: $db,
              $table: $db.usersModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> saleItemsModelRefs<T extends Object>(
      Expression<T> Function($$SaleItemsModelTableAnnotationComposer a) f) {
    final $$SaleItemsModelTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.saleItemsModel,
        getReferencedColumn: (t) => t.saleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SaleItemsModelTableAnnotationComposer(
              $db: $db,
              $table: $db.saleItemsModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SalesModelTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SalesModelTable,
    SalesModelData,
    $$SalesModelTableFilterComposer,
    $$SalesModelTableOrderingComposer,
    $$SalesModelTableAnnotationComposer,
    $$SalesModelTableCreateCompanionBuilder,
    $$SalesModelTableUpdateCompanionBuilder,
    (SalesModelData, $$SalesModelTableReferences),
    SalesModelData,
    PrefetchHooks Function({bool userId, bool saleItemsModelRefs})> {
  $$SalesModelTableTableManager(_$AppDatabase db, $SalesModelTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> customer = const Value.absent(),
          }) =>
              SalesModelCompanion(
            id: id,
            status: status,
            date: date,
            total: total,
            userId: userId,
            customer: customer,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int status,
            required DateTime date,
            required double total,
            required int userId,
            required String customer,
          }) =>
              SalesModelCompanion.insert(
            id: id,
            status: status,
            date: date,
            total: total,
            userId: userId,
            customer: customer,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SalesModelTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {userId = false, saleItemsModelRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (saleItemsModelRefs) db.saleItemsModel
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$SalesModelTableReferences._userIdTable(db),
                    referencedColumn:
                        $$SalesModelTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (saleItemsModelRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$SalesModelTableReferences
                            ._saleItemsModelRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SalesModelTableReferences(db, table, p0)
                                .saleItemsModelRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.saleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SalesModelTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SalesModelTable,
    SalesModelData,
    $$SalesModelTableFilterComposer,
    $$SalesModelTableOrderingComposer,
    $$SalesModelTableAnnotationComposer,
    $$SalesModelTableCreateCompanionBuilder,
    $$SalesModelTableUpdateCompanionBuilder,
    (SalesModelData, $$SalesModelTableReferences),
    SalesModelData,
    PrefetchHooks Function({bool userId, bool saleItemsModelRefs})>;
typedef $$SaleItemsModelTableCreateCompanionBuilder = SaleItemsModelCompanion
    Function({
  Value<int> id,
  required int saleId,
  required int menuItemId,
  required String specialIndications,
  required int quantity,
  required double subtotal,
});
typedef $$SaleItemsModelTableUpdateCompanionBuilder = SaleItemsModelCompanion
    Function({
  Value<int> id,
  Value<int> saleId,
  Value<int> menuItemId,
  Value<String> specialIndications,
  Value<int> quantity,
  Value<double> subtotal,
});

final class $$SaleItemsModelTableReferences extends BaseReferences<
    _$AppDatabase, $SaleItemsModelTable, SaleItemsModelData> {
  $$SaleItemsModelTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SalesModelTable _saleIdTable(_$AppDatabase db) =>
      db.salesModel.createAlias(
          $_aliasNameGenerator(db.saleItemsModel.saleId, db.salesModel.id));

  $$SalesModelTableProcessedTableManager? get saleId {
    if ($_item.saleId == null) return null;
    final manager = $$SalesModelTableTableManager($_db, $_db.salesModel)
        .filter((f) => f.id($_item.saleId!));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MenuItemModelTable _menuItemIdTable(_$AppDatabase db) =>
      db.menuItemModel.createAlias($_aliasNameGenerator(
          db.saleItemsModel.menuItemId, db.menuItemModel.id));

  $$MenuItemModelTableProcessedTableManager? get menuItemId {
    if ($_item.menuItemId == null) return null;
    final manager = $$MenuItemModelTableTableManager($_db, $_db.menuItemModel)
        .filter((f) => f.id($_item.menuItemId!));
    final item = $_typedResult.readTableOrNull(_menuItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SaleItemsModelTableFilterComposer
    extends Composer<_$AppDatabase, $SaleItemsModelTable> {
  $$SaleItemsModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specialIndications => $composableBuilder(
      column: $table.specialIndications,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  $$SalesModelTableFilterComposer get saleId {
    final $$SalesModelTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $db.salesModel,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SalesModelTableFilterComposer(
              $db: $db,
              $table: $db.salesModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MenuItemModelTableFilterComposer get menuItemId {
    final $$MenuItemModelTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.menuItemId,
        referencedTable: $db.menuItemModel,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuItemModelTableFilterComposer(
              $db: $db,
              $table: $db.menuItemModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SaleItemsModelTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleItemsModelTable> {
  $$SaleItemsModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specialIndications => $composableBuilder(
      column: $table.specialIndications,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  $$SalesModelTableOrderingComposer get saleId {
    final $$SalesModelTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $db.salesModel,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SalesModelTableOrderingComposer(
              $db: $db,
              $table: $db.salesModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MenuItemModelTableOrderingComposer get menuItemId {
    final $$MenuItemModelTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.menuItemId,
        referencedTable: $db.menuItemModel,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuItemModelTableOrderingComposer(
              $db: $db,
              $table: $db.menuItemModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SaleItemsModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleItemsModelTable> {
  $$SaleItemsModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get specialIndications => $composableBuilder(
      column: $table.specialIndications, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  $$SalesModelTableAnnotationComposer get saleId {
    final $$SalesModelTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $db.salesModel,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SalesModelTableAnnotationComposer(
              $db: $db,
              $table: $db.salesModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MenuItemModelTableAnnotationComposer get menuItemId {
    final $$MenuItemModelTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.menuItemId,
        referencedTable: $db.menuItemModel,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuItemModelTableAnnotationComposer(
              $db: $db,
              $table: $db.menuItemModel,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SaleItemsModelTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SaleItemsModelTable,
    SaleItemsModelData,
    $$SaleItemsModelTableFilterComposer,
    $$SaleItemsModelTableOrderingComposer,
    $$SaleItemsModelTableAnnotationComposer,
    $$SaleItemsModelTableCreateCompanionBuilder,
    $$SaleItemsModelTableUpdateCompanionBuilder,
    (SaleItemsModelData, $$SaleItemsModelTableReferences),
    SaleItemsModelData,
    PrefetchHooks Function({bool saleId, bool menuItemId})> {
  $$SaleItemsModelTableTableManager(
      _$AppDatabase db, $SaleItemsModelTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleItemsModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleItemsModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleItemsModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> saleId = const Value.absent(),
            Value<int> menuItemId = const Value.absent(),
            Value<String> specialIndications = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
          }) =>
              SaleItemsModelCompanion(
            id: id,
            saleId: saleId,
            menuItemId: menuItemId,
            specialIndications: specialIndications,
            quantity: quantity,
            subtotal: subtotal,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int saleId,
            required int menuItemId,
            required String specialIndications,
            required int quantity,
            required double subtotal,
          }) =>
              SaleItemsModelCompanion.insert(
            id: id,
            saleId: saleId,
            menuItemId: menuItemId,
            specialIndications: specialIndications,
            quantity: quantity,
            subtotal: subtotal,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SaleItemsModelTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({saleId = false, menuItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (saleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.saleId,
                    referencedTable:
                        $$SaleItemsModelTableReferences._saleIdTable(db),
                    referencedColumn:
                        $$SaleItemsModelTableReferences._saleIdTable(db).id,
                  ) as T;
                }
                if (menuItemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.menuItemId,
                    referencedTable:
                        $$SaleItemsModelTableReferences._menuItemIdTable(db),
                    referencedColumn:
                        $$SaleItemsModelTableReferences._menuItemIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SaleItemsModelTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SaleItemsModelTable,
    SaleItemsModelData,
    $$SaleItemsModelTableFilterComposer,
    $$SaleItemsModelTableOrderingComposer,
    $$SaleItemsModelTableAnnotationComposer,
    $$SaleItemsModelTableCreateCompanionBuilder,
    $$SaleItemsModelTableUpdateCompanionBuilder,
    (SaleItemsModelData, $$SaleItemsModelTableReferences),
    SaleItemsModelData,
    PrefetchHooks Function({bool saleId, bool menuItemId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersModelTableTableManager get usersModel =>
      $$UsersModelTableTableManager(_db, _db.usersModel);
  $$MenuItemModelTableTableManager get menuItemModel =>
      $$MenuItemModelTableTableManager(_db, _db.menuItemModel);
  $$SalesModelTableTableManager get salesModel =>
      $$SalesModelTableTableManager(_db, _db.salesModel);
  $$SaleItemsModelTableTableManager get saleItemsModel =>
      $$SaleItemsModelTableTableManager(_db, _db.saleItemsModel);
}
