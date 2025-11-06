// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashCutModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CashCutModelAdapter extends TypeAdapter<CashCutModel> {
  @override
  final int typeId = 7;

  @override
  CashCutModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CashCutModel(
      id: fields[0] as String?,
      date: fields[1] as DateTime,
      userId: fields[2] as String,
      initialCash: fields[3] as double,
      cashSales: fields[4] as double,
      cardSales: fields[5] as double,
      otherPaymentSales: fields[6] as double,
      countedCash: fields[7] as double,
      expenses: fields[8] as double,
      notes: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CashCutModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.initialCash)
      ..writeByte(4)
      ..write(obj.cashSales)
      ..writeByte(5)
      ..write(obj.cardSales)
      ..writeByte(6)
      ..write(obj.otherPaymentSales)
      ..writeByte(7)
      ..write(obj.countedCash)
      ..writeByte(8)
      ..write(obj.expenses)
      ..writeByte(9)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CashCutModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
