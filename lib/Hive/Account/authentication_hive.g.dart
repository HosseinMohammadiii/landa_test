// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountHiveAdapter extends TypeAdapter<AccountHive> {
  @override
  final int typeId = 0;

  @override
  AccountHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountHive(
      isLogin: fields[0] as bool?,
      token: fields[1] as String?,
      id: fields[2] as String?,
      userName: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isLogin)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.userName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
