import 'package:chicle_app_empleados/models/models.dart';
import 'package:uuid/uuid.dart';

/// Representa un corte de caja en un momento específico.
class CashCut {
  final String id;
  final DateTime date;
  final String userId; // ID del usuario que realiza el corte

  final double initialCash; // Fondo de caja inicial
  final double cashSales; // Ventas en efectivo del período
  final double cardSales; // Ventas con tarjeta del período
  final double otherPaymentSales; // Ventas con otros métodos de pago

  final double countedCash; // Efectivo físico contado en caja
  final double expenses; // Egresos de dinero (compras, etc.)
  final String? notes; // Observaciones o notas adicionales

  CashCut({
    String? id,
    required this.date,
    required this.userId,
    required this.initialCash,
    required this.cashSales,
    required this.cardSales,
    required this.otherPaymentSales,
    required this.countedCash,
    this.notes,
    this.expenses = 0.0, // Default to 0.0 if not provided
  }) : this.id = id ?? const Uuid().v4();

  /// Total de ventas del período (suma de todos los métodos de pago).
  double get totalSales => cashSales + cardSales + otherPaymentSales;

  /// Efectivo esperado en caja al final del período.
  /// Es el fondo inicial más las ventas en efectivo menos los egresos.
  double get expectedCashInDrawer => initialCash + cashSales - expenses;

  /// Diferencia entre el efectivo contado y el esperado.
  /// Un valor positivo es un sobrante, un valor negativo es un faltante.
  double get difference => countedCash - (initialCash + cashSales - expenses);

  /// Constructor para crear una instancia a partir de un `CashCutModel` de Hive.
  CashCut.fromModel(CashCutModel model)
      : id = model.id,
        date = model.date,
        userId = model.userId,
        initialCash = model.initialCash,
        cashSales = model.cashSales,
        cardSales = model.cardSales,
        otherPaymentSales = model.otherPaymentSales,
        countedCash = model.countedCash,
        notes = model.notes,
        expenses = model.expenses;

  /// Convierte la entidad de dominio a un `CashCutModel` para persistencia en Hive.
  CashCutModel toModel() {
    return CashCutModel(
      id: id,
      date: date,
      userId: userId,
      initialCash: initialCash,
      cashSales: cashSales,
      cardSales: cardSales,
      otherPaymentSales: otherPaymentSales,
      countedCash: countedCash,
      notes: notes,
      expenses: expenses,
    );
  }
}