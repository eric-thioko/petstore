part of 'update_pet_cubit.dart';

class UpdatePetState extends Equatable {
  final GenericDataState<void> state;
  const UpdatePetState({required this.state});

  factory UpdatePetState.initial() =>
      UpdatePetState(state: GenericDataState<void>.initial());

  UpdatePetState copyWith({GenericDataState<void>? state}) {
    return UpdatePetState(state: state ?? this.state);
  }

  @override
  List<Object> get props => [state];
}
