part of 'cart_cubit.dart';

class CartState extends Equatable {
  final GenericDataState<List<PetEntity>> state;
  final GenericDataState<void> actionState;

  const CartState({required this.state, required this.actionState});

  factory CartState.initial() => CartState(
        state: GenericDataState<List<PetEntity>>.initial(),
        actionState: GenericDataState<void>.initial(),
      );

  CartState copyWith({
    GenericDataState<List<PetEntity>>? state,
    GenericDataState<void>? actionState,
  }) {
    return CartState(
      state: state ?? this.state,
      actionState: actionState ?? this.actionState,
    );
  }

  @override
  List<Object> get props => [state, actionState];
}
