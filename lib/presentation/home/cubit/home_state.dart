part of 'home_cubit.dart';

class HomeState extends Equatable {
  final GenericDataState<List<PetEntity>> state;
  final GenericDataState<void> deleteState;

  const HomeState({required this.state, required this.deleteState});

  factory HomeState.initial() => HomeState(
      state: GenericDataState<List<PetEntity>>.initial(),
      deleteState: GenericDataState<void>.initial());

  HomeState copyWith({
    GenericDataState<List<PetEntity>>? state,
    GenericDataState<void>? deleteState,
  }) {
    return HomeState(
      state: state ?? this.state,
      deleteState: deleteState ?? this.deleteState,
    );
  }

  @override
  List<Object> get props => [state, deleteState];
}
