import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/core/common/state/generic_state.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';
import 'package:petstore/presentation/home/cubit/home_cubit.dart';
import '../../../fixtures/pet_fixture.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late HomeCubit cubit;
  late MockPetGet mockPetGet;
  late MockPetDelete mockPetDelete;
  late MockCartAdd mockCartAdd;

  setUp(() {
    mockPetGet = MockPetGet();
    mockPetDelete = MockPetDelete();
    mockCartAdd = MockCartAdd();
    cubit = HomeCubit(
      petGet: mockPetGet,
      petDelete: mockPetDelete,
      cartAdd: mockCartAdd,
    );
  });

  setUpAll(() {
    registerFallbackValue(PetFixture.testPet);
  });

  tearDown(() {
    cubit.close();
  });

  group('HomeCubit - getPet', () {
    blocTest<HomeCubit, HomeState>(
      'emits [loading, success] when getPet succeeds',
      build: () {
        when(() => mockPetGet.execute())
            .thenAnswer((_) async => Right(PetFixture.testPetList));
        return cubit;
      },
      act: (cubit) => cubit.getPet(),
      expect: () => [
        HomeState(
          state: GenericDataState<List<PetEntity>>.loading(),
          deleteState: GenericDataState<void>.initial(),
          addToCartState: GenericDataState<void>.initial(),
        ),
        HomeState(
          state: GenericDataState<List<PetEntity>>.success(data: PetFixture.testPetList),
          deleteState: GenericDataState<void>.initial(),
          addToCartState: GenericDataState<void>.initial(),
        ),
      ],
      verify: (_) {
        verify(() => mockPetGet.execute()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [loading, error] when getPet fails',
      build: () {
        final failure = Failure(errorMessage: 'Network error');
        when(() => mockPetGet.execute())
            .thenAnswer((_) async => Left(failure));
        return cubit;
      },
      act: (cubit) => cubit.getPet(),
      expect: () => [
        HomeState(
          state: GenericDataState<List<PetEntity>>.loading(),
          deleteState: GenericDataState<void>.initial(),
          addToCartState: GenericDataState<void>.initial(),
        ),
        HomeState(
          state: GenericDataState<List<PetEntity>>.error(
            failure: Failure(errorMessage: 'Network error'),
          ),
          deleteState: GenericDataState<void>.initial(),
          addToCartState: GenericDataState<void>.initial(),
        ),
      ],
      verify: (_) {
        verify(() => mockPetGet.execute()).called(1);
      },
    );
  });

  group('HomeCubit - deletePet', () {
    blocTest<HomeCubit, HomeState>(
      'emits [loading, success] and refreshes when delete succeeds',
      build: () {
        when(() => mockPetDelete.execute(any()))
            .thenAnswer((_) async => const Right(unit));
        when(() => mockPetGet.execute())
            .thenAnswer((_) async => Right(PetFixture.testPetList));
        return cubit;
      },
      act: (cubit) => cubit.deletePet(PetFixture.testPet),
      expect: () => [
        HomeState(
          state: GenericDataState<List<PetEntity>>.initial(),
          deleteState: GenericDataState<void>.loading(),
          addToCartState: GenericDataState<void>.initial(),
        ),
        HomeState(
          state: GenericDataState<List<PetEntity>>.initial(),
          deleteState: GenericDataState<void>.success(data: null),
          addToCartState: GenericDataState<void>.initial(),
        ),
        // After delete success, getPet is called
        HomeState(
          state: GenericDataState<List<PetEntity>>.loading(),
          deleteState: GenericDataState<void>.success(data: null),
          addToCartState: GenericDataState<void>.initial(),
        ),
        HomeState(
          state: GenericDataState<List<PetEntity>>.success(data: PetFixture.testPetList),
          deleteState: GenericDataState<void>.success(data: null),
          addToCartState: GenericDataState<void>.initial(),
        ),
      ],
      verify: (_) {
        verify(() => mockPetDelete.execute(PetFixture.testPet)).called(1);
        verify(() => mockPetGet.execute()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [loading, error] when delete fails',
      build: () {
        final failure = Failure(errorMessage: 'Delete failed');
        when(() => mockPetDelete.execute(any()))
            .thenAnswer((_) async => Left(failure));
        return cubit;
      },
      act: (cubit) => cubit.deletePet(PetFixture.testPet),
      expect: () => [
        HomeState(
          state: GenericDataState<List<PetEntity>>.initial(),
          deleteState: GenericDataState<void>.loading(),
          addToCartState: GenericDataState<void>.initial(),
        ),
        HomeState(
          state: GenericDataState<List<PetEntity>>.initial(),
          deleteState: GenericDataState<void>.error(
            failure: Failure(errorMessage: 'Delete failed'),
          ),
          addToCartState: GenericDataState<void>.initial(),
        ),
      ],
      verify: (_) {
        verify(() => mockPetDelete.execute(PetFixture.testPet)).called(1);
        verifyNever(() => mockPetGet.execute());
      },
    );
  });

  group('HomeCubit - addToCart', () {
    blocTest<HomeCubit, HomeState>(
      'emits [loading, success] when addToCart succeeds',
      build: () {
        when(() => mockCartAdd.execute(any()))
            .thenAnswer((_) async => const Right(unit));
        return cubit;
      },
      act: (cubit) => cubit.addToCart(PetFixture.testPet),
      expect: () => [
        HomeState(
          state: GenericDataState<List<PetEntity>>.initial(),
          deleteState: GenericDataState<void>.initial(),
          addToCartState: GenericDataState<void>.loading(),
        ),
        HomeState(
          state: GenericDataState<List<PetEntity>>.initial(),
          deleteState: GenericDataState<void>.initial(),
          addToCartState: GenericDataState<void>.success(data: null),
        ),
      ],
      verify: (_) {
        verify(() => mockCartAdd.execute(PetFixture.testPet)).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [loading, error] when addToCart fails',
      build: () {
        final failure = Failure(errorMessage: 'Already in cart');
        when(() => mockCartAdd.execute(any()))
            .thenAnswer((_) async => Left(failure));
        return cubit;
      },
      act: (cubit) => cubit.addToCart(PetFixture.testPet),
      expect: () => [
        HomeState(
          state: GenericDataState<List<PetEntity>>.initial(),
          deleteState: GenericDataState<void>.initial(),
          addToCartState: GenericDataState<void>.loading(),
        ),
        HomeState(
          state: GenericDataState<List<PetEntity>>.initial(),
          deleteState: GenericDataState<void>.initial(),
          addToCartState: GenericDataState<void>.error(
            failure: Failure(errorMessage: 'Already in cart'),
          ),
        ),
      ],
      verify: (_) {
        verify(() => mockCartAdd.execute(PetFixture.testPet)).called(1);
      },
    );
  });

  test('initial state should be correct', () {
    expect(
      cubit.state,
      HomeState(
        state: GenericDataState<List<PetEntity>>.initial(),
        deleteState: GenericDataState<void>.initial(),
        addToCartState: GenericDataState<void>.initial(),
      ),
    );
  });
}
