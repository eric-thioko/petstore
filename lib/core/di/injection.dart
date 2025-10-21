import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

/// Dependency Injection Container
/// Follows Single Responsibility Principle
class DependencyInjection {
  DependencyInjection._();

  static const String _baseUrl = 'https://petstore3.swagger.io';

  /// Setup all dependencies
  static List<RepositoryProvider> getRepositories() {
    return [
      // Network Layer
      ..._getNetworkDependencies(),

      // Data Sources
      ..._getDataSourceDependencies(),

      // Repositories
      ..._getRepositoryDependencies(),

      // Use Cases - Pet
      ..._getPetUseCaseDependencies(),

      // Use Cases - Cart
      ..._getCartUseCaseDependencies(),
    ];
  }

  static List<RepositoryProvider> _getNetworkDependencies() {
    return [
      RepositoryProvider<Dio>(
        create: (_) => Dio(
          BaseOptions(
            baseUrl: _baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        )..interceptors.addAll([
            LogInterceptor(
              requestBody: true,
              responseBody: true,
              logPrint: (obj) => debugPrint(obj.toString()),
            ),
          ]),
      ),
      RepositoryProvider<Endpoints>(
        create: (_) => Endpoints(baseUrl: _baseUrl),
      ),
      RepositoryProvider<ApiClient>(
        create: (context) => ApiClient(dio: context.read<Dio>()),
      ),
    ];
  }

  static List<RepositoryProvider> _getDataSourceDependencies() {
    return [
      RepositoryProvider<PetRemoteDataSource>(
        create: (context) => PetRemoteDataSourceImpl(
          client: context.read<ApiClient>(),
          endpoints: context.read<Endpoints>(),
        ),
      ),
      RepositoryProvider<CartLocalDataSource>(
        create: (_) => CartLocalDataSourceImpl(),
      ),
    ];
  }

  static List<RepositoryProvider> _getRepositoryDependencies() {
    return [
      RepositoryProvider<PetRepository>(
        create: (context) => PetRepositoryImpl(
          remoteDataSource: context.read<PetRemoteDataSource>(),
        ),
      ),
      RepositoryProvider<CartRepository>(
        create: (context) => CartRepositoryImpl(
          localDataSource: context.read<CartLocalDataSource>(),
        ),
      ),
    ];
  }

  static List<RepositoryProvider> _getPetUseCaseDependencies() {
    return [
      RepositoryProvider<PetAdd>(
        create: (context) => PetAdd(repository: context.read<PetRepository>()),
      ),
      RepositoryProvider<PetGet>(
        create: (context) => PetGet(repository: context.read<PetRepository>()),
      ),
      RepositoryProvider<PetDelete>(
        create: (context) =>
            PetDelete(repository: context.read<PetRepository>()),
      ),
      RepositoryProvider<PetUpdate>(
        create: (context) =>
            PetUpdate(repository: context.read<PetRepository>()),
      ),
    ];
  }

  static List<RepositoryProvider> _getCartUseCaseDependencies() {
    return [
      RepositoryProvider<CartAdd>(
        create: (context) => CartAdd(repository: context.read<CartRepository>()),
      ),
      RepositoryProvider<CartGet>(
        create: (context) => CartGet(repository: context.read<CartRepository>()),
      ),
      RepositoryProvider<CartRemove>(
        create: (context) =>
            CartRemove(repository: context.read<CartRepository>()),
      ),
      RepositoryProvider<CartCheckout>(
        create: (context) =>
            CartCheckout(repository: context.read<CartRepository>()),
      ),
    ];
  }
}
