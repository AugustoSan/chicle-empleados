import '../enums/enums.dart';

class Business {
  final String name;                // Nombre del local
  final String currency;            // Ej: "MXN", "USD"
  final double taxPercent;          // IVA u otro impuesto
  final BusinessType type;          // Tipo de negocio
  final List<String> enabledModules;// Ej: ["mesas","takeaway","delivery"]
  final String? logo;

  Business({
    required this.name,
    required this.currency,
    required this.taxPercent,
    required this.type,
    required this.enabledModules,
    this.logo,
  });

  Business copyWith({
    String? name,
    String? currency,
    double? taxPercent,
    BusinessType? type,
    List<String>? enabledModules,
    String? logo,
  }) {
    return Business(
      name:           name         ?? this.name,
      currency:       currency     ?? this.currency,
      taxPercent:     taxPercent   ?? this.taxPercent,
      type:           type         ?? this.type,
      enabledModules: enabledModules ?? this.enabledModules,
      logo:           logo         ?? this.logo,
    );
  }
}
