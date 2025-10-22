import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/data/repository/pet/pet_repository.dart';
import '../../fixtures/pet_fixture.dart';
import '../../helpers/test_helper.dart';

void main() {
  late PetRepositoryImpl repository;
  late MockPetRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockPetRemoteDataSource();
    repository = PetRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  setUpAll(() {
    registerFallbackValue(PetFixture.testPet);
    registerFallbackValue(FakePetAddRequest());
    registerFallbackValue(FakePetDeleteRequest());
    registerFallbackValue(FakePetUpdateRequest());
  });

  group('PetRepository - getPets', () {
    test('should return list of pets when data source succeeds', () async {
      // arrange
      final testPetResponses = PetFixture.testPetResponseList;
      when(() => mockRemoteDataSource.getPets())
          .thenAnswer((_) async => Right(testPetResponses));

      // act
      final result = await repository.getPet();

      // assert
      expect(result.isRight(), true);
      result.fold(
        (l) => fail('Should return Right'),
        (pets) {
          expect(pets.length, 2);
          expect(pets[0].name, 'Test Dog');
          expect(pets[1].name, 'Test Cat');
        },
      );
      verify(() => mockRemoteDataSource.getPets()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return failure when data source fails', () async {
      // arrange
      final failure = Failure(errorMessage: 'Server error');
      when(() => mockRemoteDataSource.getPets())
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await repository.getPet();

      // assert
      expect(result, Left(failure));
      verify(() => mockRemoteDataSource.getPets()).called(1);
    });
  });

  group('PetRepository - addPet', () {
    test('should add pet when data source succeeds', () async {
      // arrange
      final testPet = PetFixture.testPet;
      when(() => mockRemoteDataSource.addPet(request: any(named: 'request')))
          .thenAnswer((_) async => const Right(unit));

      // act
      final result = await repository.addPet(pet: testPet);

      // assert
      expect(result, const Right(unit));
      verify(() => mockRemoteDataSource.addPet(request: any(named: 'request')))
          .called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return failure when data source fails', () async {
      // arrange
      final testPet = PetFixture.testPet;
      final failure = Failure(errorMessage: 'Failed to add pet');
      when(() => mockRemoteDataSource.addPet(request: any(named: 'request')))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await repository.addPet(pet: testPet);

      // assert
      expect(result, Left(failure));
      verify(() => mockRemoteDataSource.addPet(request: any(named: 'request')))
          .called(1);
    });
  });

  group('PetRepository - deletePet', () {
    test('should delete pet when data source succeeds', () async {
      // arrange
      final testPet = PetFixture.testPet;
      when(() => mockRemoteDataSource.deletePet(request: any(named: 'request')))
          .thenAnswer((_) async => const Right(unit));

      // act
      final result = await repository.deletePet(pet: testPet);

      // assert
      expect(result, const Right(unit));
      verify(() => mockRemoteDataSource.deletePet(request: any(named: 'request')))
          .called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return failure when data source fails', () async {
      // arrange
      final testPet = PetFixture.testPet;
      final failure = Failure(errorMessage: 'Failed to delete');
      when(() => mockRemoteDataSource.deletePet(request: any(named: 'request')))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await repository.deletePet(pet: testPet);

      // assert
      expect(result, Left(failure));
      verify(() => mockRemoteDataSource.deletePet(request: any(named: 'request')))
          .called(1);
    });
  });

  group('PetRepository - updatePet', () {
    test('should update pet when data source succeeds', () async {
      // arrange
      final updatedPet = PetFixture.updatedPet;
      when(() => mockRemoteDataSource.updatePet(request: any(named: 'request')))
          .thenAnswer((_) async => const Right(unit));

      // act
      final result = await repository.updatePet(pet: updatedPet);

      // assert
      expect(result, const Right(unit));
      verify(() => mockRemoteDataSource.updatePet(request: any(named: 'request')))
          .called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return failure when data source fails', () async {
      // arrange
      final updatedPet = PetFixture.updatedPet;
      final failure = Failure(errorMessage: 'Update failed');
      when(() => mockRemoteDataSource.updatePet(request: any(named: 'request')))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await repository.updatePet(pet: updatedPet);

      // assert
      expect(result, Left(failure));
      verify(() => mockRemoteDataSource.updatePet(request: any(named: 'request')))
          .called(1);
    });
  });
}
