import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petstore/core/common/state/generic_state.dart';
import 'package:petstore/domain/entity/category_entity.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';
import 'package:petstore/domain/entity/tags_entity.dart';
import 'package:petstore/domain/usecase/pet/pet_update.dart';

part 'update_pet_state.dart';

class UpdatePetCubit extends Cubit<UpdatePetState> {
  final PetUpdate petUpdate;

  UpdatePetCubit({required this.petUpdate}) : super(UpdatePetState.initial());

  Future<void> updatePet({
    required int id,
    required String name,
    required String categoryName,
    required String status,
    List<String>? photoUrls,
    List<String>? tagNames,
  }) async {
    emit(state.copyWith(state: GenericDataState.loading()));

    // Create entity
    final petEntity = PetEntity(
      id: id,
      name: name,
      category: CategoryEntity(
        id: 1,
        name: categoryName,
      ),
      photoUrls: photoUrls ?? [],
      tags: tagNames
              ?.asMap()
              .entries
              .map((entry) => TagsEntity(
                    id: entry.key + 1,
                    name: entry.value,
                  ))
              .toList() ??
          [],
      status: status,
    );

    final result = await petUpdate.execute(petEntity);
    result.fold(
      (failure) =>
          emit(state.copyWith(state: GenericDataState.error(failure: failure))),
      (success) => emit(state.copyWith(state: GenericDataState.success())),
    );
  }

  void resetState() {
    emit(UpdatePetState.initial());
  }
}
