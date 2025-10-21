import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petstore/core/common/state/generic_state.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';
import 'package:petstore/domain/usecase/cart/cart_add.dart';
import 'package:petstore/domain/usecase/cart/cart_checkout.dart';
import 'package:petstore/domain/usecase/cart/cart_get.dart';
import 'package:petstore/domain/usecase/cart/cart_remove.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartAdd cartAdd;
  final CartGet cartGet;
  final CartRemove cartRemove;
  final CartCheckout cartCheckout;

  CartCubit({
    required this.cartAdd,
    required this.cartGet,
    required this.cartRemove,
    required this.cartCheckout,
  }) : super(CartState.initial());

  Future<void> getCartPets() async {
    emit(state.copyWith(state: GenericDataState.loading()));
    final result = await cartGet.execute();
    result.fold(
      (failure) =>
          emit(state.copyWith(state: GenericDataState.error(failure: failure))),
      (pets) => emit(state.copyWith(state: GenericDataState.success(data: pets))),
    );
  }

  Future<void> addToCart(PetEntity pet) async {
    emit(state.copyWith(actionState: GenericDataState.loading()));
    final result = await cartAdd.execute(pet);
    result.fold(
      (failure) => emit(
          state.copyWith(actionState: GenericDataState.error(failure: failure))),
      (success) {
        emit(state.copyWith(actionState: GenericDataState.success()));
        getCartPets(); // Refresh cart
      },
    );
  }

  Future<void> removeFromCart(int petId) async {
    emit(state.copyWith(actionState: GenericDataState.loading()));
    final result = await cartRemove.execute(petId);
    result.fold(
      (failure) => emit(
          state.copyWith(actionState: GenericDataState.error(failure: failure))),
      (success) {
        emit(state.copyWith(actionState: GenericDataState.success()));
        getCartPets(); // Refresh cart
      },
    );
  }

  Future<void> checkout() async {
    emit(state.copyWith(actionState: GenericDataState.loading()));
    final result = await cartCheckout.execute();
    result.fold(
      (failure) => emit(
          state.copyWith(actionState: GenericDataState.error(failure: failure))),
      (success) {
        emit(state.copyWith(actionState: GenericDataState.success()));
        getCartPets(); // Refresh cart (will be empty)
      },
    );
  }
}
