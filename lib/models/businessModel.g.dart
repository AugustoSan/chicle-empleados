// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'businessModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusinessModelAdapter extends TypeAdapter<BusinessModel> {
  @override
  final int typeId = 1;

  @override
  BusinessModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BusinessModel(
      name: fields[0] as String,
      currency: fields[1] as String,
      taxPercent: fields[2] as double,
      type: fields[3] as int,
      enabledModules: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BusinessModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.currency)
      ..writeByte(2)
      ..write(obj.taxPercent)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.enabledModules);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
