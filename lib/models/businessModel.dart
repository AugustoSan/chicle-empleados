import 'package:hive/hive.dart';

part 'businessModel.g.dart';


@HiveType(typeId: 1)
class BusinessModel extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  String currency;

  @HiveField(2)
  double initialCash;

  @HiveField(3)
  double taxPercent;

  @HiveField(4)
  int type;

  @HiveField(5)
  List<String> enabledModules;

  @HiveField(6)
  String? address;

  @HiveField(7)
  String? phone;

  @HiveField(8)
  String? logo;

  BusinessModel({
    required this.name,
    required this.currency,
    required this.taxPercent,
    required this.initialCash,
    required this.type,
    required this.enabledModules,
    this.address,
    this.phone,
    this.logo,
  });

  /// Este es el método `copyWith` que te faltaba:
  BusinessModel copyWith({
    String? name,
    String? currency,
    double? initialCash,
    double? taxPercent,
    int? type,
    List<String>? enabledModules,
    String? address,
    String? phone,
    String? logo,
  }) {
    return BusinessModel(
      name:   name ?? this.name,
      currency:   currency ?? this.currency,
      initialCash:   initialCash ?? this.initialCash,
      taxPercent:   taxPercent ?? this.taxPercent,
      type:   type ?? this.type,
      enabledModules:   enabledModules ?? this.enabledModules,
      address:   address ?? this.address,
      phone:   phone ?? this.phone,
      logo:   logo ?? this.logo,
    );
  }
}