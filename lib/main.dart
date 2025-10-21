import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:petstore/core/common/bloc_observer.dart';
import 'package:petstore/core/common/theme/theme.dart';
import 'package:petstore/core/network/api_client.dart';
import 'package:petstore/core/network/endpoints.dart';
import 'package:petstore/core/router/router.dart';
import 'package:petstore/data/repository/cart/cart_repository.dart';
import 'package:petstore/data/repository/cart/data_source/cart_local_data_source.dart';
import 'package:petstore/data/repository/cart/model/pet_entity_adapter.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(PetEntityAdapter());

  Bloc.observer = AppBlocObserver();
  final String baseUrl = 'https://petstore3.swagger.io';
  runApp(
    MultiRepositoryProvider(
      providers: [
        // Core - Network
        RepositoryProvider<Dio>(
          create: (_) => Dio(
            BaseOptions(
              baseUrl: baseUrl,
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
            ),
          ),
        ),
        RepositoryProvider<Endpoints>(
          create: (_) => Endpoints(baseUrl: baseUrl),
        ),
        RepositoryProvider<ApiClient>(
          create: (context) => ApiClient(dio: context.read<Dio>()),
        ),

        // Data Source
        RepositoryProvider<PetRemoteDataSource>(
          create: (context) => PetRemoteDataSourceImpl(
            client: context.read<ApiClient>(),
            endpoints: context.read<Endpoints>(),
          ),
        ),

        // Repository
        RepositoryProvider<PetRepository>(
          create: (context) => PetRepositoryImpl(
            remoteDataSource: context.read<PetRemoteDataSource>(),
          ),
        ),

        // Cart Data Source & Repository
        RepositoryProvider<CartLocalDataSource>(
          create: (_) => CartLocalDataSourceImpl(),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartRepositoryImpl(
            localDataSource: context.read<CartLocalDataSource>(),
          ),
        ),

        // Pet Use Cases
        RepositoryProvider<PetAdd>(
          create: (context) =>
              PetAdd(repository: context.read<PetRepository>()),
        ),
        RepositoryProvider<PetGet>(
          create: (context) =>
              PetGet(repository: context.read<PetRepository>()),
        ),
        RepositoryProvider<PetDelete>(
          create: (context) =>
              PetDelete(repository: context.read<PetRepository>()),
        ),
        RepositoryProvider<PetUpdate>(
          create: (context) =>
              PetUpdate(repository: context.read<PetRepository>()),
        ),

        // Cart Use Cases
        RepositoryProvider<CartAdd>(
          create: (context) =>
              CartAdd(repository: context.read<CartRepository>()),
        ),
        RepositoryProvider<CartGet>(
          create: (context) =>
              CartGet(repository: context.read<CartRepository>()),
        ),
        RepositoryProvider<CartRemove>(
          create: (context) =>
              CartRemove(repository: context.read<CartRepository>()),
        ),
        RepositoryProvider<CartCheckout>(
          create: (context) =>
              CartCheckout(repository: context.read<CartRepository>()),
        ),
      ],
      child: const PetStoreApp(),
    ),
  );
}

class PetStoreApp extends StatelessWidget {
  const PetStoreApp({super.key});
  @override
  Widget build(BuildContext context) {
    final goRouter = createRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: goRouter,
      title: 'Pet Store',
    );
  }
}
