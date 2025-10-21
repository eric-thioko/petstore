import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:petstore/core/network/api_client.dart';
import 'package:petstore/core/network/endpoints.dart';
import 'package:petstore/data/repository/cart/cart_repository.dart';
import 'package:petstore/data/repository/cart/data_source/cart_local_data_source.dart';
import 'package:petstore/data/repository/pet/data_source/pet_remote_data_source.dart';
import 'package:petstore/data/repository/pet/pet_repository.dart';
import 'package:petstore/domain/usecase/cart/cart_add.dart';
import 'package:petstore/domain/usecase/cart/cart_checkout.dart';
import 'package:petstore/domain/usecase/cart/cart_get.dart';
import 'package:petstore/domain/usecase/cart/cart_remove.dart';
import 'package:petstore/domain/usecase/pet/pet_add.dart';
import 'package:petstore/domain/usecase/pet/pet_delete.dart';
import 'package:petstore/domain/usecase/pet/pet_get.dart';
import 'package:petstore/domain/usecase/pet/pet_update.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  const String baseUrl = 'https://petstore3.swagger.io';

  // Core - Network
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    ),
  );

  sl.registerLazySingleton<Endpoints>(
    () => Endpoints(baseUrl: baseUrl),
  );

  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: sl<Dio>()),
  );

  // Data Sources
  sl.registerLazySingleton<PetRemoteDataSource>(
    () => PetRemoteDataSourceImpl(
      client: sl<ApiClient>(),
      endpoints: sl<Endpoints>(),
    ),
  );

  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<PetRepository>(
    () => PetRepositoryImpl(
      remoteDataSource: sl<PetRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      localDataSource: sl<CartLocalDataSource>(),
    ),
  );

  // Use Cases - Pet
  sl.registerLazySingleton<PetAdd>(
    () => PetAdd(repository: sl<PetRepository>()),
  );

  sl.registerLazySingleton<PetGet>(
    () => PetGet(repository: sl<PetRepository>()),
  );

  sl.registerLazySingleton<PetDelete>(
    () => PetDelete(repository: sl<PetRepository>()),
  );

  sl.registerLazySingleton<PetUpdate>(
    () => PetUpdate(repository: sl<PetRepository>()),
  );

  // Use Cases - Cart
  sl.registerLazySingleton<CartAdd>(
    () => CartAdd(repository: sl<CartRepository>()),
  );

  sl.registerLazySingleton<CartGet>(
    () => CartGet(repository: sl<CartRepository>()),
  );

  sl.registerLazySingleton<CartRemove>(
    () => CartRemove(repository: sl<CartRepository>()),
  );

  sl.registerLazySingleton<CartCheckout>(
    () => CartCheckout(repository: sl<CartRepository>()),
  );
}
