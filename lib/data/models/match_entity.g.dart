// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatchEntityAdapter extends TypeAdapter<MatchEntity> {
  @override
  final int typeId = 3;

  @override
  MatchEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatchEntity(
      id: fields[0] as String,
      matchTypeIndex: fields[1] as int,
      dateTime: fields[2] as DateTime,
      playingSideIndex: fields[3] as int,
      partner: fields[4] as PlayerEntity,
      opponent1: fields[5] as PlayerEntity,
      opponent2: fields[6] as PlayerEntity,
      result: fields[7] as MatchResultEntity,
      performanceRating: fields[8] as int?,
      notes: fields[9] as String?,
      durationInMinutes: fields[10] as int?,
      location: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MatchEntity obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.matchTypeIndex)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.playingSideIndex)
      ..writeByte(4)
      ..write(obj.partner)
      ..writeByte(5)
      ..write(obj.opponent1)
      ..writeByte(6)
      ..write(obj.opponent2)
      ..writeByte(7)
      ..write(obj.result)
      ..writeByte(8)
      ..write(obj.performanceRating)
      ..writeByte(9)
      ..write(obj.notes)
      ..writeByte(10)
      ..write(obj.durationInMinutes)
      ..writeByte(11)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
