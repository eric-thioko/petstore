import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petstore/core/router/routes.dart';
import 'package:petstore/domain/usecase/cart/cart_add.dart';
import 'package:petstore/domain/usecase/pet/pet_get.dart';
import 'package:petstore/domain/usecase/pet/pet_delete.dart';
import 'package:petstore/presentation/home/cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit(
      petGet: context.read<PetGet>(),
      petDelete: context.read<PetDelete>(),
    )..getPet();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  void refreshPets() {
    _homeCubit.getPet();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeCubit,
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void _showDeleteConfirmation(BuildContext context, pet) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Pet'),
        content: Text('Are you sure you want to delete ${pet.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<HomeCubit>().deletePet(pet);
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Store'),
        actions: [
          if (kIsWeb)
            IconButton(
              onPressed: () {
                context.read<HomeCubit>().getPet();
              },
              icon: Icon(Icons.refresh),
            ),
        ],
      ),
      body: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) =>
            previous.deleteState != current.deleteState,
        listener: (context, state) {
          if (state.deleteState.status.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pet deleted successfully'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.deleteState.status.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.deleteState.failure?.errorMessage ??
                      'Failed to delete pet',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final dataState = state.state;
            if (dataState.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (dataState.status.isError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      dataState.failure?.errorMessage ?? 'An error occurred',
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<HomeCubit>().getPet(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (dataState.status.isSuccess) {
              final pets = dataState.data ?? [];
              if (pets.isEmpty) {
                return const Center(child: Text('No pets available'));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeCubit>().getPet();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: pet.photoUrls.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: pet.photoUrls.first,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) =>
                                      const Icon(Icons.pets, size: 40),
                                ),
                              )
                            : const Icon(Icons.pets, size: 40),
                        title: Text(
                          pet.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Category: ${pet.category.name}'),
                            Text('Status: ${pet.status}'),
                            if (pet.tags.isNotEmpty)
                              Wrap(
                                spacing: 4,
                                children: pet.tags
                                    .map(
                                      (tag) => Chip(
                                        label: Text(
                                          tag.name,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                    )
                                    .toList(),
                              ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add_shopping_cart),
                              onPressed: () async {
                                final cartAdd = context.read<CartAdd>();
                                final result = await cartAdd.execute(pet);
                                if (context.mounted) {
                                  result.fold(
                                    (failure) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(failure.errorMessage),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                    (success) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Added to cart'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                await context.push(
                                  Routes.updatePet,
                                  extra: pet,
                                );
                                if (context.mounted) {
                                  context.read<HomeCubit>().getPet();
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _showDeleteConfirmation(context, pet);
                              },
                            ),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
              );
            }

            return const Center(child: Text('No data'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push(Routes.addPet);
          if (context.mounted) {
            context.read<HomeCubit>().getPet();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
