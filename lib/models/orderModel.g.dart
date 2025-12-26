// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 5;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      id: fields[0] as String?,
      date: fields[2] as DateTime?,
      total: fields[4] as double?,
      statusCashCut: fields[6] as bool?,
      typePayment: fields[7] as int?,
      userId: fields[1] as String,
      customer: fields[3] as String,
      status: fields[5] as int,
      items: (fields[8] as List).cast<OrderItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.customer)
      ..writeByte(4)
      ..write(obj.total)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.statusCashCut)
      ..writeByte(7)
      ..write(obj.typePayment)
      ..writeByte(8)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
