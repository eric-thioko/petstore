// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:petstore/data/repository/pet/model/pet_get_response.dart';
import 'package:petstore/domain/entity/category_entity.dart';
import 'package:petstore/domain/entity/tags_entity.dart';

class PetEntity extends Equatable {
  final int id;
  final String name;
  final CategoryEntity category;
  final List<String> photoUrls;
  final List<TagsEntity> tags;
  final String status;

  const PetEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.photoUrls,
    required this.tags,
    required this.status,
  });

  factory PetEntity.fromResponse(PetGetResponse response) {
    return PetEntity(
      id: response.id?.toInt() ?? 0,
      name: response.name ?? '',
      category: response.category != null
          ? CategoryEntity(
              id: response.category!.id?.toInt() ?? 0,
              name: response.category!.name ?? '',
            )
          : CategoryEntity(id: 0, name: ''),
      photoUrls: response.photoUrls ?? [],
      tags: response.tags
              ?.map((tag) => TagsEntity(
                    id: tag.id?.toInt() ?? 0,
                    name: tag.name ?? '',
                  ))
              .toList() ??
          [],
      status: response.status ?? '',
    );
  }

  @override
  List<Object> get props {
    return [id, name, category, photoUrls, tags, status];
  }

  PetEntity copyWith({
    int? id,
    String? name,
    CategoryEntity? category,
    List<String>? photoUrls,
    List<TagsEntity>? tags,
    String? status,
  }) {
    return PetEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      photoUrls: photoUrls ?? this.photoUrls,
      tags: tags ?? this.tags,
      status: status ?? this.status,
    );
  }
}
