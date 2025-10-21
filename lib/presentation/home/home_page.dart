import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petstore/core/common/widgets/confirmation_dialog.dart';
import 'package:petstore/core/common/widgets/empty_state.dart';
import 'package:petstore/core/common/widgets/error_state.dart';
import 'package:petstore/core/common/widgets/loading_indicator.dart';
import 'package:petstore/core/di/service_locator.dart';
import 'package:petstore/core/router/routes.dart';
import 'package:petstore/domain/usecase/pet/pet_delete.dart';
import 'package:petstore/domain/usecase/pet/pet_get.dart';
import 'package:petstore/domain/usecase/cart/cart_add.dart';
import 'package:petstore/presentation/home/cubit/home_cubit.dart';
import 'package:petstore/presentation/home/widgets/pet_card.dart';

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
      petGet: sl<PetGet>(),
      petDelete: sl<PetDelete>(),
      cartAdd: sl<CartAdd>(),
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
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  void _showDeleteConfirmation(BuildContext context, pet) {
    ConfirmationDialog.show(
      context,
      ConfirmationDialog.delete(
        itemName: pet.name,
        onConfirm: () => context.read<HomeCubit>().deletePet(pet),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<HomeCubit, HomeState>(
            listenWhen: (previous, current) =>
                previous.deleteState != current.deleteState,
            listener: _handleDeleteStateChange,
          ),
          BlocListener<HomeCubit, HomeState>(
            listenWhen: (previous, current) =>
                previous.addToCartState != current.addToCartState,
            listener: _handleAddToCartStateChange,
          ),
        ],
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => _buildBody(context, state),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddPet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _handleDeleteStateChange(BuildContext context, HomeState state) {
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
            state.deleteState.failure?.errorMessage ?? 'Failed to delete pet',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleAddToCartStateChange(BuildContext context, HomeState state) {
    if (state.addToCartState.status.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to cart'),
          backgroundColor: Colors.green,
        ),
      );
    } else if (state.addToCartState.status.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.addToCartState.failure?.errorMessage ?? 'Failed to add to cart',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    final dataState = state.state;

    if (dataState.status.isLoading) {
      return const LoadingIndicator();
    }

    if (dataState.status.isError) {
      return ErrorState(
        message: dataState.failure?.errorMessage ?? 'An error occurred',
        onRetry: () => context.read<HomeCubit>().getPet(),
      );
    }

    if (dataState.status.isSuccess) {
      final pets = dataState.data ?? [];

      if (pets.isEmpty) {
        return const EmptyState(
          icon: Icons.pets,
          message: 'No pets available',
        );
      }

      return _buildPetList(context, pets);
    }

    return const EmptyState(
      icon: Icons.info_outline,
      message: 'No data',
    );
  }

  Widget _buildPetList(BuildContext context, List pets) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeCubit>().getPet();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return PetCard(
            pet: pet,
            onDeletePressed: () => _showDeleteConfirmation(context, pet),
          );
        },
      ),
    );
  }

  Future<void> _navigateToAddPet(BuildContext context) async {
    await context.push(Routes.addPet);
    if (context.mounted) {
      context.read<HomeCubit>().getPet();
    }
  }
}
