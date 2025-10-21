import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petstore/core/common/state/generic_state.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';
import 'package:petstore/domain/usecase/pet/pet_get.dart';
import 'package:petstore/domain/usecase/pet/pet_delete.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PetGet petGet;
  final PetDelete petDelete;

  HomeCubit({required this.petGet, required this.petDelete})
      : super(HomeState.initial());

  Future<void> getPet() async {
    emit(state.copyWith(state: GenericDataState.loading()));
    final result = await petGet.execute();
    result.fold(
      (fail) =>
          emit(state.copyWith(state: GenericDataState.error(failure: fail))),
      (success) =>
          emit(state.copyWith(state: GenericDataState.success(data: success))),
    );
  }

  Future<void> deletePet(PetEntity pet) async {
    emit(state.copyWith(deleteState: GenericDataState.loading()));
    final result = await petDelete.execute(pet);
    result.fold(
      (fail) => emit(
          state.copyWith(deleteState: GenericDataState.error(failure: fail))),
      (success) {
        emit(state.copyWith(deleteState: GenericDataState.success(data: null)));
        getPet(); // Refresh the list after successful delete
      },
    );
  }
}
