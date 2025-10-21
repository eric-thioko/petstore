import 'package:dartz/dartz.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/data/repository/cart/cart_repository.dart';

class CartCheckout {
  final CartRepository repository;

  CartCheckout({required this.repository});

  Future<Either<Failure, Unit>> execute() async {
    return await repository.checkout();
  }
}
