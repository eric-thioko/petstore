import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/data/repository/cart/cart_repository.dart';
import '../../fixtures/pet_fixture.dart';
import '../../helpers/test_helper.dart';

void main() {
  late CartRepositoryImpl repository;
  late MockCartLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockCartLocalDataSource();
    repository = CartRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  setUpAll(() {
    registerFallbackValue(PetFixture.testPet);
  });

  group('CartRepository - addToCart', () {
    test('should add pet to cart when data source succeeds', () async {
      // arrange
      final testPet = PetFixture.testPet;
      when(() => mockLocalDataSource.addToCart(pet: any(named: 'pet')))
          .thenAnswer((_) async => const Right(unit));

      // act
      final result = await repository.addToCart(pet: testPet);

      // assert
      expect(result, const Right(unit));
      verify(() => mockLocalDataSource.addToCart(pet: testPet)).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return failure when pet already in cart', () async {
      // arrange
      final testPet = PetFixture.testPet;
      final failure = Failure(errorMessage: 'Pet already in cart');
      when(() => mockLocalDataSource.addToCart(pet: any(named: 'pet')))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await repository.addToCart(pet: testPet);

      // assert
      expect(result, Left(failure));
      verify(() => mockLocalDataSource.addToCart(pet: testPet)).called(1);
    });
  });

  group('CartRepository - getCartPets', () {
    test('should return list of cart pets when data source succeeds', () async {
      // arrange
      final testPets = PetFixture.testPetList;
      when(() => mockLocalDataSource.getCartPets())
          .thenAnswer((_) async => Right(testPets));

      // act
      final result = await repository.getCartPets();

      // assert
      expect(result, Right(testPets));
      verify(() => mockLocalDataSource.getCartPets()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return empty list when cart is empty', () async {
      // arrange
      when(() => mockLocalDataSource.getCartPets())
          .thenAnswer((_) async => const Right([]));

      // act
      final result = await repository.getCartPets();

      // assert
      expect(result.isRight(), true);
      result.fold(
        (l) => fail('Should return Right'),
        (pets) => expect(pets, []),
      );
      verify(() => mockLocalDataSource.getCartPets()).called(1);
    });
  });

  group('CartRepository - removeFromCart', () {
    test('should remove pet from cart when data source succeeds', () async {
      // arrange
      const petId = 1;
      when(() => mockLocalDataSource.removeFromCart(petId: any(named: 'petId')))
          .thenAnswer((_) async => const Right(unit));

      // act
      final result = await repository.removeFromCart(petId: petId);

      // assert
      expect(result, const Right(unit));
      verify(() => mockLocalDataSource.removeFromCart(petId: petId)).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return failure when data source fails', () async {
      // arrange
      const petId = 1;
      final failure = Failure(errorMessage: 'Failed to remove');
      when(() => mockLocalDataSource.removeFromCart(petId: any(named: 'petId')))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await repository.removeFromCart(petId: petId);

      // assert
      expect(result, Left(failure));
      verify(() => mockLocalDataSource.removeFromCart(petId: petId)).called(1);
    });
  });

  group('CartRepository - clearCart', () {
    test('should clear cart when data source succeeds', () async {
      // arrange
      when(() => mockLocalDataSource.clearCart())
          .thenAnswer((_) async => const Right(unit));

      // act
      final result = await repository.checkout();

      // assert
      expect(result, const Right(unit));
      verify(() => mockLocalDataSource.clearCart()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return failure when data source fails', () async {
      // arrange
      final failure = Failure(errorMessage: 'Failed to clear cart');
      when(() => mockLocalDataSource.clearCart())
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await repository.checkout();

      // assert
      expect(result, Left(failure));
      verify(() => mockLocalDataSource.clearCart()).called(1);
    });
  });
}
