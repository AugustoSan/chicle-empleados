import 'package:chicle_app_empleados/models/models.dart';

import '../enums/enums.dart';

class Business {
  final String name;                // Nombre del local
  final String currency;            // Ej: "MXN", "USD"
  final double initialCash;        // Efectivo inicial en caja
  final double taxPercent;          // IVA u otro impuesto
  final BusinessType type;          // Tipo de negocio
  final List<String> enabledModules;// Ej: ["mesas","takeaway","delivery"]
  final String? address;
  final String? phone;
  final String? logo;

  Business({
    required this.name,
    required this.currency,
    required this.initialCash,
    required this.taxPercent,
    required this.type,
    required this.enabledModules,
    this.address,
    this.phone,
    this.logo,
  });

  Business.chicle() :
    this.name = 'Chicle App',
    this.currency = 'MXN',
    this.initialCash = 500.0,
    this.taxPercent = 16.0,
    this.type = BusinessType.cafeteria,
    this.enabledModules = ['mesas', 'takeaway', 'delivery'],
    this.address = null,
    this.phone = null,
    this.logo = null;

  Business copyWith({
    String? name,
    String? currency,
    double? initialCash,
    double? taxPercent,
    BusinessType? type,
    List<String>? enabledModules,
    String? address,
    String? phone,
    String? logo,
  }) {
    return Business(
      name:           name         ?? this.name,
      currency:       currency     ?? this.currency,
      initialCash:    initialCash  ?? this.initialCash,
      taxPercent:     taxPercent   ?? this.taxPercent,
      type:           type         ?? this.type,
      enabledModules: enabledModules ?? this.enabledModules,
      address:        address      ?? this.address,
      phone:          phone        ?? this.phone,
      logo:           logo         ?? this.logo,
    );
  }

  Business.fromModel(BusinessModel model) :
    name = model.name,
    currency = model.currency,
    initialCash = model.initialCash,
    taxPercent = model.taxPercent,
    type = BusinessType.values[model.type],
    enabledModules = model.enabledModules,
    address = model.address,
    phone = model.phone,
    logo = model.logo;
  
  BusinessModel parseToModel() => BusinessModel(
    name: name,
    currency: currency,
    initialCash: initialCash,
    taxPercent: taxPercent,
    type: type.index,
    enabledModules: enabledModules,
    address: address,
    phone: phone,
    logo: logo,
  );
}
