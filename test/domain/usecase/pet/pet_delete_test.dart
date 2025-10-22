import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/domain/usecase/pet/pet_delete.dart';
import '../../../fixtures/pet_fixture.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late PetDelete usecase;
  late MockPetRepository mockRepository;

  setUp(() {
    mockRepository = MockPetRepository();
    usecase = PetDelete(repository: mockRepository);
  });

  setUpAll(() {
    registerFallbackValue(PetFixture.testPet);
  });

  group('PetDelete UseCase', () {
    test('should delete pet successfully', () async {
      // arrange
      final testPet = PetFixture.testPet;
      when(
        () => mockRepository.deletePet(pet: testPet),
      ).thenAnswer((_) async => const Right(unit));

      // act
      final result = await usecase.execute(testPet);

      // assert
      expect(result, const Right(unit));
      verify(() => mockRepository.deletePet(pet: testPet)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when delete fails', () async {
      // arrange
      final testPet = PetFixture.testPet;
      final failure = Failure(errorMessage: 'Failed to delete pet');
      when(
        () => mockRepository.deletePet(pet: testPet),
      ).thenAnswer((_) async => Left(failure));

      // act
      final result = await usecase.execute(testPet);

      // assert
      expect(result, Left(failure));
      verify(() => mockRepository.deletePet(pet: testPet)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should call repository with correct pet', () async {
      // arrange
      final testPet = PetFixture.testPet;
      when(
        () => mockRepository.deletePet(pet: testPet),
      ).thenAnswer((_) async => const Right(unit));

      // act
      await usecase.execute(testPet);

      // assert
      verify(() => mockRepository.deletePet(pet: testPet)).called(1);
    });
  });
}
