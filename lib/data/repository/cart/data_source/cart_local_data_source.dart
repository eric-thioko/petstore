import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';
import 'package:petstore/core/common/exception/failure.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';

abstract class CartLocalDataSource {
  Future<Either<Failure, Unit>> addToCart({required PetEntity pet});
  Future<Either<Failure, List<PetEntity>>> getCartPets();
  Future<Either<Failure, Unit>> removeFromCart({required int petId});
  Future<Either<Failure, Unit>> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  static const String _cartBoxName = 'cart_pets';

  Future<Box<PetEntity>> get _cartBox async => await Hive.openBox<PetEntity>(_cartBoxName);

  @override
  Future<Either<Failure, Unit>> addToCart({required PetEntity pet}) async {
    try {
      final box = await _cartBox;

      // Check if pet already exists in cart
      final existingPet = box.values.where((p) => p.id == pet.id).firstOrNull;
      if (existingPet != null) {
        return Left(Failure(errorMessage: 'Pet already in cart'));
      }

      await box.put(pet.id, pet);
      return Right(unit);
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PetEntity>>> getCartPets() async {
    try {
      final box = await _cartBox;
      final pets = box.values.toList();
      return Right(pets);
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromCart({required int petId}) async {
    try {
      final box = await _cartBox;
      await box.delete(petId);
      return Right(unit);
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearCart() async {
    try {
      final box = await _cartBox;
      await box.clear();
      return Right(unit);
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
