import 'package:dartz/dartz.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/data/repository/pet/pet_repository.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';

class PetUpdate {
  final PetRepository repository;

  PetUpdate({required this.repository});

  Future<Either<Failure, Unit>> execute(PetEntity pet) async {
    return repository.updatePet(pet: pet);
  }
}
