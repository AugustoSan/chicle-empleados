import 'package:hive/hive.dart';

part 'customerModel.g.dart';


@HiveType(typeId: 2)
class CustomerModel extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String? email;

  CustomerModel({
    required this.name,
    required this.phone,
    this.email,
  });

  /// Este es el método `copyWith` que te faltaba:
  CustomerModel copyWith({
    String? name,
    String? phone,
    String? email
  }) {
    return CustomerModel(
      name:   name ?? this.name,
      phone:  phone ?? this.phone,
      email:  email ?? this.email,
    );
  }
}