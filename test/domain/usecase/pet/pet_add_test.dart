import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';
import 'package:petstore/domain/usecase/pet/pet_add.dart';
import '../../../fixtures/pet_fixture.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late PetAdd usecase;
  late MockPetRepository mockRepository;

  setUp(() {
    mockRepository = MockPetRepository();
    usecase = PetAdd(repository: mockRepository);
  });

  setUpAll(() {
    registerFallbackValue(PetFixture.testPet);
  });

  group('PetAdd UseCase', () {
    test('should add pet successfully', () async {
      // arrange
      final testPet = PetFixture.testPet;
      when(
        () => mockRepository.addPet(pet: testPet),
      ).thenAnswer((_) async => const Right(unit));

      // act
      final result = await usecase.execute(testPet);

      // assert
      expect(result, const Right(unit));
      verify(() => mockRepository.addPet(pet: testPet)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when adding pet fails', () async {
      // arrange
      final testPet = PetFixture.testPet;
      final failure = Failure(errorMessage: 'Failed to add pet');
      when(
        () => mockRepository.addPet(pet: testPet),
      ).thenAnswer((_) async => Left(failure));

      // act
      final result = await usecase.execute(testPet);

      // assert
      expect(result, Left(failure));
      verify(() => mockRepository.addPet(pet: testPet)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should pass correct pet entity to repository', () async {
      // arrange
      final testPet = PetFixture.testPet;
      when(
        () => mockRepository.addPet(pet: testPet),
      ).thenAnswer((_) async => const Right(unit));

      // act
      await usecase.execute(testPet);

      // assert
      final captured = verify(
        () => mockRepository.addPet(pet: captureAny(named: 'pet')),
      ).captured;
      final capturedPet = captured.first as PetEntity;
      expect(capturedPet.name, testPet.name);
      expect(capturedPet.category.name, testPet.category.name);
      expect(capturedPet.status, testPet.status);
    });
  });
}
