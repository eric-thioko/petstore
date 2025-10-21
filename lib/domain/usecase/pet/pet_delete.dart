import 'package:dartz/dartz.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/data/repository/pet/pet_repository.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';

class PetDelete {
  final PetRepository repository;

  PetDelete({required this.repository});
  Future<Either<Failure, Unit>> execute(PetEntity pet) async {
    return repository.deletePet(pet: pet);
  }
}
