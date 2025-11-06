import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'cashCutModel.g.dart';




@HiveType(typeId: 7)
class CashCutModel extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String userId;

  @HiveField(3)
  double initialCash;

  @HiveField(4)
  double cashSales;

  @HiveField(5)
  double cardSales;

  @HiveField(6)
  double otherPaymentSales;

  @HiveField(7)
  double countedCash;

  @HiveField(8)
  double expenses;

  @HiveField(9)
  String? notes;


  CashCutModel({
    String? id,
    required this.date,
    required this.userId,
    required this.initialCash,
    required this.cashSales,
    required this.cardSales,
    required this.otherPaymentSales,
    required this.countedCash,
    this.expenses = 0.0,
    this.notes,
  }) : this.id = id ?? const Uuid().v4(); // Asigna el ID proporcionado o genera uno nuevo
}