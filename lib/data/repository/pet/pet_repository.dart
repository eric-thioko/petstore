import 'package:dartz/dartz.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/data/repository/pet/data_source/pet_remote_data_source.dart';
import 'package:petstore/data/repository/pet/model/pet_add_request.dart';
import 'package:petstore/data/repository/pet/model/pet_delete_request.dart';
import 'package:petstore/data/repository/pet/model/pet_update_request.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';

abstract class PetRepository {
  Future<Either<Failure, Unit>> addPet({required PetEntity pet});
  Future<Either<Failure, List<PetEntity>>> getPet();
  Future<Either<Failure, Unit>> deletePet({required PetEntity pet});
  Future<Either<Failure, Unit>> updatePet({required PetEntity pet});
}

class PetRepositoryImpl implements PetRepository {
  final PetRemoteDataSource remoteDataSource;
  PetRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Unit>> addPet({required PetEntity pet}) async {
    final request = PetAddRequest(
      id: pet.id,
      name: pet.name,
      category: PetAddCategoryRequest(
        id: pet.category.id,
        name: pet.category.name,
      ),
      photoUrls: pet.photoUrls,
      tags: pet.tags
          .map((tag) => PetAddTagsRequest(id: tag.id, name: tag.name))
          .toList(),
      status: pet.status,
    );

    final result = await remoteDataSource.addPet(request: request);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, List<PetEntity>>> getPet() async {
    final result = await remoteDataSource.getPets();
    return result.fold(
      (failure) => Left(failure),
      (success) => Right(
        List<PetEntity>.from(success.map((x) => PetEntity.fromResponse(x))),
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePet({required PetEntity pet}) async {
    final result = await remoteDataSource.deletePet(
      request: PetDeleteRequest(petId: pet.id),
    );
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, Unit>> updatePet({required PetEntity pet}) async {
    final request = PetUpdateRequest(
      id: pet.id,
      name: pet.name,
      category: PetUpdateCategoryRequest(
        id: pet.category.id,
        name: pet.category.name,
      ),
      photoUrls: pet.photoUrls,
      tags: pet.tags
          .map((tag) => PetUpdateTagsRequest(id: tag.id, name: tag.name))
          .toList(),
      status: pet.status,
    );

    final result = await remoteDataSource.updatePet(request: request);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
}
