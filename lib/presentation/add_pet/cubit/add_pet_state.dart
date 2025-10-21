part of 'add_pet_cubit.dart';

class AddPetState extends Equatable {
  final GenericDataState<void> state;
  const AddPetState({required this.state});

  factory AddPetState.initial() =>
      AddPetState(state: GenericDataState<void>.initial());

  AddPetState copyWith({GenericDataState<void>? state}) {
    return AddPetState(state: state ?? this.state);
  }

  @override
  List<Object> get props => [state];
}
