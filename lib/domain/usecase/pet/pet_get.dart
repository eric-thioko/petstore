import 'package:dartz/dartz.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/data/repository/pet/pet_repository.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';

class PetGet {
  final PetRepository repository;

  PetGet({required this.repository});

  Future<Either<Failure, List<PetEntity>>> execute() async {
    return repository.getPet();
  }
}
