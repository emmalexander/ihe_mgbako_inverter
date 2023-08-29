// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatabaseModelAdapter extends TypeAdapter<DatabaseModel> {
  @override
  final int typeId = 0;

  @override
  DatabaseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DatabaseModel()
      ..appliance = fields[0] as String
      ..quantity = fields[1] as String
      ..power = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, DatabaseModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.appliance)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.power);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatabaseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
