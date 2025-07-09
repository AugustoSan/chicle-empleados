// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumerModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsumerModelAdapter extends TypeAdapter<ConsumerModel> {
  @override
  final int typeId = 1;

  @override
  ConsumerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConsumerModel(
      name: fields[0] as String,
      phone: fields[1] as String,
      email: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ConsumerModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsumerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
