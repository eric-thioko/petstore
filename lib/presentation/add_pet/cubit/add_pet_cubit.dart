import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petstore/core/common/state/generic_state.dart';
import 'package:petstore/domain/entity/category_entity.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';
import 'package:petstore/domain/entity/tags_entity.dart';
import 'package:petstore/domain/usecase/pet/pet_add.dart';

part 'add_pet_state.dart';

class AddPetCubit extends Cubit<AddPetState> {
  final PetAdd petAdd;

  AddPetCubit({required this.petAdd}) : super(AddPetState.initial());

  Future<void> addPet({
    required String name,
    required String categoryName,
    required String status,
    List<String>? photoUrls,
    List<String>? tagNames,
  }) async {
    emit(state.copyWith(state: GenericDataState.loading()));

    // Create entity
    final petEntity = PetEntity(
      id: DateTime.now().millisecondsSinceEpoch,
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

    final result = await petAdd.execute(petEntity);
    result.fold(
      (failure) =>
          emit(state.copyWith(state: GenericDataState.error(failure: failure))),
      (success) => emit(state.copyWith(state: GenericDataState.success())),
    );
  }

  void resetState() {
    emit(AddPetState.initial());
  }
}
