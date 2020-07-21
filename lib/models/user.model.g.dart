// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User()
      ..userId = fields[0] as String
      ..username = fields[1] as String
      ..name = fields[2] as String
      ..email = fields[3] as String
      ..isAdmin = fields[4] as bool
      ..token = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.isAdmin)
      ..writeByte(5)
      ..write(obj.token);
  }
}
