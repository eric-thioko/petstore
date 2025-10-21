import 'package:dartz/dartz.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/data/repository/cart/data_source/cart_local_data_source.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, Unit>> addToCart({required PetEntity pet});
  Future<Either<Failure, List<PetEntity>>> getCartPets();
  Future<Either<Failure, Unit>> removeFromCart({required int petId});
  Future<Either<Failure, Unit>> checkout();
}

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Unit>> addToCart({required PetEntity pet}) async {
    return await localDataSource.addToCart(pet: pet);
  }

  @override
  Future<Either<Failure, List<PetEntity>>> getCartPets() async {
    return await localDataSource.getCartPets();
  }

  @override
  Future<Either<Failure, Unit>> removeFromCart({required int petId}) async {
    return await localDataSource.removeFromCart(petId: petId);
  }

  @override
  Future<Either<Failure, Unit>> checkout() async {
    // In real app, this would call API to process checkout
    // For now, we just clear the cart
    return await localDataSource.clearCart();
  }
}
