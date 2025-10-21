import 'package:dartz/dartz.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/data/repository/cart/cart_repository.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';

class CartAdd {
  final CartRepository repository;

  CartAdd({required this.repository});

  Future<Either<Failure, Unit>> execute(PetEntity pet) async {
    return await repository.addToCart(pet: pet);
  }
}
