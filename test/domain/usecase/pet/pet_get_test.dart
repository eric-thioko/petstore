import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/domain/usecase/pet/pet_get.dart';
import '../../../fixtures/pet_fixture.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late PetGet usecase;
  late MockPetRepository mockRepository;

  setUp(() {
    mockRepository = MockPetRepository();
    usecase = PetGet(repository: mockRepository);
  });

  group('PetGet UseCase', () {
    test('should get list of pets from repository', () async {
      // arrange
      final testPets = PetFixture.testPetList;
      when(() => mockRepository.getPet())
          .thenAnswer((_) async => Right(testPets));

      // act
      final result = await usecase.execute();

      // assert
      expect(result, Right(testPets));
      verify(() => mockRepository.getPet()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository fails', () async {
      // arrange
      final failure = Failure(errorMessage: 'Network error');
      when(() => mockRepository.getPet())
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await usecase.execute();

      // assert
      expect(result, Left(failure));
      verify(() => mockRepository.getPet()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return empty list when no pets available', () async {
      // arrange
      when(() => mockRepository.getPet())
          .thenAnswer((_) async => const Right([]));

      // act
      final result = await usecase.execute();

      // assert
      expect(result.isRight(), true);
      result.fold(
        (l) => fail('Should return Right'),
        (pets) => expect(pets, []),
      );
      verify(() => mockRepository.getPet()).called(1);
    });
  });
}
