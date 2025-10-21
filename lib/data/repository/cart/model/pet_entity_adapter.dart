import 'package:hive_ce/hive.dart';
import 'package:petstore/domain/entity/category_entity.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';
import 'package:petstore/domain/entity/tags_entity.dart';

class PetEntityAdapter extends TypeAdapter<PetEntity> {
  @override
  final int typeId = 0;

  @override
  PetEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return PetEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      category: CategoryEntity(
        id: fields[2] as int,
        name: fields[3] as String,
      ),
      photoUrls: (fields[4] as List).cast<String>(),
      tags: (fields[5] as List).map((tag) {
        final tagMap = tag as Map;
        return TagsEntity(
          id: tagMap['id'] as int,
          name: tagMap['name'] as String,
        );
      }).toList(),
      status: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PetEntity obj) {
    writer
      ..writeByte(7) // number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category.id)
      ..writeByte(3)
      ..write(obj.category.name)
      ..writeByte(4)
      ..write(obj.photoUrls)
      ..writeByte(5)
      ..write(obj.tags.map((e) => {'id': e.id, 'name': e.name}).toList())
      ..writeByte(6)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
