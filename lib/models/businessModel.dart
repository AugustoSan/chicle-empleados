import 'package:hive/hive.dart';

part 'businessModel.g.dart';


@HiveType(typeId: 1)
class BusinessModel extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  String currency;

  @HiveField(2)
  double taxPercent;

  @HiveField(3)
  int type;

  @HiveField(4)
  List<String> enabledModules;

  @HiveField(5)
  String? address;

  @HiveField(6)
  String? phone;

  @HiveField(7)
  String? logo;

  BusinessModel({
    required this.name,
    required this.currency,
    required this.taxPercent,
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
      taxPercent:   taxPercent ?? this.taxPercent,
      type:   type ?? this.type,
      enabledModules:   enabledModules ?? this.enabledModules,
      address:   address ?? this.address,
      phone:   phone ?? this.phone,
      logo:   logo ?? this.logo,
    );
  }
}