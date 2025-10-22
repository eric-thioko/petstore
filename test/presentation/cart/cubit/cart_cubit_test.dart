import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/core/common/state/generic_state.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';
import 'package:petstore/presentation/cart/cubit/cart_cubit.dart';
import '../../../fixtures/pet_fixture.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late CartCubit cubit;
  late MockCartGet mockCartGet;
  late MockCartAdd mockCartAdd;
  late MockCartRemove mockCartRemove;
  late MockCartCheckout mockCartCheckout;

  setUp(() {
    mockCartGet = MockCartGet();
    mockCartAdd = MockCartAdd();
    mockCartRemove = MockCartRemove();
    mockCartCheckout = MockCartCheckout();
    cubit = CartCubit(
      cartGet: mockCartGet,
      cartAdd: mockCartAdd,
      cartRemove: mockCartRemove,
      cartCheckout: mockCartCheckout,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('CartCubit - getCartPets', () {
    blocTest<CartCubit, CartState>(
      'emits [loading, success] when getCartPets succeeds',
      build: () {
        when(() => mockCartGet.execute())
            .thenAnswer((_) async => Right(PetFixture.testPetList));
        return cubit;
      },
      act: (cubit) => cubit.getCartPets(),
      expect: () => [
        CartState(
          state: GenericDataState<List<PetEntity>>.loading(),
          actionState: GenericDataState<void>.initial(),
        ),
        CartState(
          state: GenericDataState<List<PetEntity>>.success(data: PetFixture.testPetList),
          actionState: GenericDataState<void>.initial(),
        ),
      ],
      verify: (_) {
        verify(() => mockCartGet.execute()).called(1);
      },
    );

    blocTest<CartCubit, CartState>(
      'emits [loading, success] with empty List<PetEntity> when cart is empty',
      build: () {
        when(() => mockCartGet.execute())
            .thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.getCartPets(),
      expect: () => [
        CartState(
          state: GenericDataState<List<PetEntity>>.loading(),
          actionState: GenericDataState<void>.initial(),
        ),
        CartState(
          state: GenericDataState<List<PetEntity>>.success(data: const []),
          actionState: GenericDataState<void>.initial(),
        ),
      ],
      verify: (_) {
        verify(() => mockCartGet.execute()).called(1);
      },
    );

    blocTest<CartCubit, CartState>(
      'emits [loading, error] when getCartPets fails',
      build: () {
        final failure = Failure(errorMessage: 'Storage error');
        when(() => mockCartGet.execute())
            .thenAnswer((_) async => Left(failure));
        return cubit;
      },
      act: (cubit) => cubit.getCartPets(),
      expect: () => [
        CartState(
          state: GenericDataState<List<PetEntity>>.loading(),
          actionState: GenericDataState<void>.initial(),
        ),
        CartState(
          state: GenericDataState<List<PetEntity>>.error(
            failure: Failure(errorMessage: 'Storage error'),
          ),
          actionState: GenericDataState<void>.initial(),
        ),
      ],
      verify: (_) {
        verify(() => mockCartGet.execute()).called(1);
      },
    );
  });

  group('CartCubit - removeFromCart', () {
    blocTest<CartCubit, CartState>(
      'emits [loading, success] and refreshes when remove succeeds',
      build: () {
        when(() => mockCartRemove.execute(any()))
            .thenAnswer((_) async => const Right(unit));
        when(() => mockCartGet.execute())
            .thenAnswer((_) async => Right(PetFixture.testPetList));
        return cubit;
      },
      act: (cubit) => cubit.removeFromCart(1),
      expect: () => [
        CartState(
          state: GenericDataState<List<PetEntity>>.initial(),
          actionState: GenericDataState<void>.loading(),
        ),
        CartState(
          state: GenericDataState<List<PetEntity>>.initial(),
          actionState: GenericDataState<void>.success(data: null),
        ),
        // After remove success, getCartPets is called
        CartState(
          state: GenericDataState<List<PetEntity>>.loading(),
          actionState: GenericDataState<void>.success(data: null),
        ),
        CartState(
          state: GenericDataState<List<PetEntity>>.success(data: PetFixture.testPetList),
          actionState: GenericDataState<void>.success(data: null),
        ),
      ],
      verify: (_) {
        verify(() => mockCartRemove.execute(1)).called(1);
        verify(() => mockCartGet.execute()).called(1);
      },
    );

    blocTest<CartCubit, CartState>(
      'emits [loading, error] when remove fails',
      build: () {
        final failure = Failure(errorMessage: 'Remove failed');
        when(() => mockCartRemove.execute(any()))
            .thenAnswer((_) async => Left(failure));
        return cubit;
      },
      act: (cubit) => cubit.removeFromCart(1),
      expect: () => [
        CartState(
          state: GenericDataState<List<PetEntity>>.initial(),
          actionState: GenericDataState<void>.loading(),
        ),
        CartState(
          state: GenericDataState<List<PetEntity>>.initial(),
          actionState: GenericDataState<void>.error(
            failure: Failure(errorMessage: 'Remove failed'),
          ),
        ),
      ],
      verify: (_) {
        verify(() => mockCartRemove.execute(1)).called(1);
        verifyNever(() => mockCartGet.execute());
      },
    );
  });

  group('CartCubit - checkout', () {
    blocTest<CartCubit, CartState>(
      'emits [loading, success] and refreshes when checkout succeeds',
      build: () {
        when(() => mockCartCheckout.execute())
            .thenAnswer((_) async => const Right(unit));
        when(() => mockCartGet.execute())
            .thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.checkout(),
      expect: () => [
        CartState(
          state: GenericDataState<List<PetEntity>>.initial(),
          actionState: GenericDataState<void>.loading(),
        ),
        CartState(
          state: GenericDataState<List<PetEntity>>.initial(),
          actionState: GenericDataState<void>.success(data: null),
        ),
        // After checkout success, getCartPets is called (should be empty)
        CartState(
          state: GenericDataState<List<PetEntity>>.loading(),
          actionState: GenericDataState<void>.success(data: null),
        ),
        CartState(
          state: GenericDataState<List<PetEntity>>.success(data: const []),
          actionState: GenericDataState<void>.success(data: null),
        ),
      ],
      verify: (_) {
        verify(() => mockCartCheckout.execute()).called(1);
        verify(() => mockCartGet.execute()).called(1);
      },
    );

    blocTest<CartCubit, CartState>(
      'emits [loading, error] when checkout fails',
      build: () {
        final failure = Failure(errorMessage: 'Checkout failed');
        when(() => mockCartCheckout.execute())
            .thenAnswer((_) async => Left(failure));
        return cubit;
      },
      act: (cubit) => cubit.checkout(),
      expect: () => [
        CartState(
          state: GenericDataState<List<PetEntity>>.initial(),
          actionState: GenericDataState<void>.loading(),
        ),
        CartState(
          state: GenericDataState<List<PetEntity>>.initial(),
          actionState: GenericDataState<void>.error(
            failure: Failure(errorMessage: 'Checkout failed'),
          ),
        ),
      ],
      verify: (_) {
        verify(() => mockCartCheckout.execute()).called(1);
        verifyNever(() => mockCartGet.execute());
      },
    );
  });

  test('initial state should be correct', () {
    expect(
      cubit.state,
      CartState(
        state: GenericDataState<List<PetEntity>>.initial(),
        actionState: GenericDataState<void>.initial(),
      ),
    );
  });
}
