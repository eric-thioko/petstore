import 'package:mocktail/mocktail.dart';
import 'package:petstore/data/repository/cart/cart_repository.dart';
import 'package:petstore/data/repository/cart/data_source/cart_local_data_source.dart';
import 'package:petstore/data/repository/pet/data_source/pet_remote_data_source.dart';
import 'package:petstore/data/repository/pet/model/pet_add_request.dart';
import 'package:petstore/data/repository/pet/model/pet_delete_request.dart';
import 'package:petstore/data/repository/pet/model/pet_update_request.dart';
import 'package:petstore/data/repository/pet/pet_repository.dart';
import 'package:petstore/domain/usecase/cart/cart_add.dart';
import 'package:petstore/domain/usecase/cart/cart_checkout.dart';
import 'package:petstore/domain/usecase/cart/cart_get.dart';
import 'package:petstore/domain/usecase/cart/cart_remove.dart';
import 'package:petstore/domain/usecase/pet/pet_add.dart';
import 'package:petstore/domain/usecase/pet/pet_delete.dart';
import 'package:petstore/domain/usecase/pet/pet_get.dart';
import 'package:petstore/domain/usecase/pet/pet_update.dart';

// Data Source Mocks
class MockPetRemoteDataSource extends Mock implements PetRemoteDataSource {}

class MockCartLocalDataSource extends Mock implements CartLocalDataSource {}

// Repository Mocks
class MockPetRepository extends Mock implements PetRepository {}

class MockCartRepository extends Mock implements CartRepository {}

// UseCase Mocks
class MockPetGet extends Mock implements PetGet {}

class MockPetAdd extends Mock implements PetAdd {}

class MockPetUpdate extends Mock implements PetUpdate {}

class MockPetDelete extends Mock implements PetDelete {}

class MockCartGet extends Mock implements CartGet {}

class MockCartAdd extends Mock implements CartAdd {}

class MockCartRemove extends Mock implements CartRemove {}

class MockCartCheckout extends Mock implements CartCheckout {}

// Fake classes for fallback values
class FakePetAddRequest extends Fake implements PetAddRequest {}

class FakePetDeleteRequest extends Fake implements PetDeleteRequest {}

class FakePetUpdateRequest extends Fake implements PetUpdateRequest {}
