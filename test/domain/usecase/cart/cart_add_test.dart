import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/domain/usecase/cart/cart_add.dart';
import '../../../fixtures/pet_fixture.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late CartAdd usecase;
  late MockCartRepository mockRepository;

  setUp(() {
    mockRepository = MockCartRepository();
    usecase = CartAdd(repository: mockRepository);
  });

  setUpAll(() {
    registerFallbackValue(PetFixture.testPet);
  });

  group('CartAdd UseCase', () {
    test('should add pet to cart successfully', () async {
      // arrange
      final testPet = PetFixture.testPet;
      when(() => mockRepository.addToCart(pet: any(named: 'pet')))
          .thenAnswer((_) async => const Right(unit));

      // act
      final result = await usecase.execute(testPet);

      // assert
      expect(result, const Right(unit));
      verify(() => mockRepository.addToCart(pet: testPet)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when pet already in cart', () async {
      // arrange
      final testPet = PetFixture.testPet;
      final failure = Failure(errorMessage: 'Pet already in cart');
      when(() => mockRepository.addToCart(pet: any(named: 'pet')))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await usecase.execute(testPet);

      // assert
      expect(result, Left(failure));
      verify(() => mockRepository.addToCart(pet: testPet)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when cart operation fails', () async {
      // arrange
      final testPet = PetFixture.testPet;
      final failure = Failure(errorMessage: 'Storage error');
      when(() => mockRepository.addToCart(pet: any(named: 'pet')))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await usecase.execute(testPet);

      // assert
      expect(result, Left(failure));
      verify(() => mockRepository.addToCart(pet: testPet)).called(1);
    });
  });
}
