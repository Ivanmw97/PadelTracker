// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padel_set_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PadelSetEntityAdapter extends TypeAdapter<PadelSetEntity> {
  @override
  final int typeId = 1;

  @override
  PadelSetEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PadelSetEntity(
      userTeamGames: fields[0] as int,
      opponentTeamGames: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PadelSetEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userTeamGames)
      ..writeByte(1)
      ..write(obj.opponentTeamGames);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PadelSetEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
