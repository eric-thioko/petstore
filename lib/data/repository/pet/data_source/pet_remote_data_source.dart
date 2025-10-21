import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/core/common/exception/failure_mapper.dart';
import 'package:petstore/core/network/api_client.dart';
import 'package:petstore/core/network/endpoints.dart';
import 'package:petstore/data/repository/pet/model/pet_add_request.dart';
import 'package:petstore/data/repository/pet/model/pet_delete_request.dart';
import 'package:petstore/data/repository/pet/model/pet_get_response.dart';
import 'package:petstore/data/repository/pet/model/pet_update_request.dart';

abstract class PetRemoteDataSource {
  Future<Either<Failure, Unit>> addPet({required PetAddRequest request});
  Future<Either<Failure, Unit>> deletePet({required PetDeleteRequest request});
  Future<Either<Failure, List<PetGetResponse>>> getPets();
  Future<Either<Failure, Unit>> updatePet({required PetUpdateRequest request});
}

class PetRemoteDataSourceImpl implements PetRemoteDataSource {
  final ApiClient client;
  final Endpoints endpoints;
  PetRemoteDataSourceImpl({required this.client, required this.endpoints});

  @override
  Future<Either<Failure, Unit>> addPet({required PetAddRequest request}) async {
    try {
      await client.post(endpoints.pet, data: request.toJson());
      return Right(unit);
    } catch (e, s) {
      return Left(mapExceptionToFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, List<PetGetResponse>>> getPets() async {
    try {
      final response = await client.get(
        "${endpoints.pet}/findByStatus?status=available",
      );
      return Right(
        List<PetGetResponse>.from(
          response.data?.map((x) => PetGetResponse.fromJson(x)),
        ),
      );
    } catch (e, s) {
      return Left(mapExceptionToFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePet({
    required PetDeleteRequest request,
  }) async {
    try {
      await client.delete(
        "${endpoints.pet}/${request.petId}",
        options: Options(
          headers: {"api_key": request.header},
          responseType: ResponseType.plain,
        ),
      );
      return Right(unit);
    } catch (e, s) {
      return Left(mapExceptionToFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePet({
    required PetUpdateRequest request,
  }) async {
    try {
      await client.put(endpoints.pet, data: request.toJson());
      return Right(unit);
    } catch (e, s) {
      return Left(mapExceptionToFailure(e, s));
    }
  }
}
