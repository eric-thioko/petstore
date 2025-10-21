part of 'home_cubit.dart';

class HomeState extends Equatable {
  final GenericDataState<List<PetEntity>> state;
  final GenericDataState<void> deleteState;
  final GenericDataState<void> addToCartState;

  const HomeState({
    required this.state,
    required this.deleteState,
    required this.addToCartState,
  });

  factory HomeState.initial() => HomeState(
        state: GenericDataState<List<PetEntity>>.initial(),
        deleteState: GenericDataState<void>.initial(),
        addToCartState: GenericDataState<void>.initial(),
      );

  HomeState copyWith({
    GenericDataState<List<PetEntity>>? state,
    GenericDataState<void>? deleteState,
    GenericDataState<void>? addToCartState,
  }) {
    return HomeState(
      state: state ?? this.state,
      deleteState: deleteState ?? this.deleteState,
      addToCartState: addToCartState ?? this.addToCartState,
    );
  }

  @override
  List<Object> get props => [state, deleteState, addToCartState];
}
