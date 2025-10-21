import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petstore/core/common/bloc_observer.dart';
import 'package:petstore/core/common/theme/theme.dart';
import 'package:petstore/core/network/api_client.dart';
import 'package:petstore/core/network/endpoints.dart';
import 'package:petstore/core/router/router.dart';
import 'package:petstore/data/repository/pet/data_source/pet_remote_data_source.dart';
import 'package:petstore/data/repository/pet/pet_repository.dart';
import 'package:petstore/domain/usecase/pet/pet_add.dart';
import 'package:petstore/domain/usecase/pet/pet_delete.dart';
import 'package:petstore/domain/usecase/pet/pet_get.dart';
import 'package:petstore/domain/usecase/pet/pet_update.dart';

void main() {
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

        // Use Cases
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
