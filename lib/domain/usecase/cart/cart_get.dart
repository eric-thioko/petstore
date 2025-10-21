import 'package:dartz/dartz.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/data/repository/cart/cart_repository.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';

class CartGet {
  final CartRepository repository;

  CartGet({required this.repository});

  Future<Either<Failure, List<PetEntity>>> execute() async {
    return await repository.getCartPets();
  }
}
