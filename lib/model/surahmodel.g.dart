// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surahmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurahModelAdapter extends TypeAdapter<SurahModel> {
  @override
  final int typeId = 1;

  @override
  SurahModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurahModel()
      ..name = fields[0] as String
      ..id = fields[1] as int
      ..status = fields[2] as String
      ..currentAyah = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, SurahModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.currentAyah);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
