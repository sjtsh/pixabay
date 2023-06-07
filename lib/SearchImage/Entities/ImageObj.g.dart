// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImageObj.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageObjAdapter extends TypeAdapter<ImageObj> {
  @override
  final int typeId = 0;

  @override
  ImageObj read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageObj(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImageObj obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.owner)
      ..writeByte(3)
      ..write(obj.size);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageObjAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
