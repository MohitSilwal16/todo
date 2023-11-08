// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shawtydata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShawtyDataAdapter extends TypeAdapter<ShawtyData> {
  @override
  final int typeId = 0;

  @override
  ShawtyData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShawtyData(
      name: fields[0] as String,
      completed: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ShawtyData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShawtyDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
