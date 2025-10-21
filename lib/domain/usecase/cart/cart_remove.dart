import 'package:dartz/dartz.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/data/repository/cart/cart_repository.dart';

class CartRemove {
  final CartRepository repository;

  CartRemove({required this.repository});

  Future<Either<Failure, Unit>> execute(int petId) async {
    return await repository.removeFromCart(petId: petId);
  }
}
