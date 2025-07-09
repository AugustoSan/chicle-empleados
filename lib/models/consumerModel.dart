import 'package:hive/hive.dart';

part 'consumerModel.g.dart';


@HiveType(typeId: 1)
class ConsumerModel extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String? email;

  ConsumerModel({
    required this.name,
    required this.phone,
    this.email,
  });

  /// Este es el método `copyWith` que te faltaba:
  ConsumerModel copyWith({
    String? name,
    String? phone,
    String? email
  }) {
    return ConsumerModel(
      name:   name ?? this.name,
      phone:  phone ?? this.phone,
      email:  email ?? this.email,
    );
  }
}