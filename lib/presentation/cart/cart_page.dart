import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petstore/domain/usecase/cart/cart_add.dart';
import 'package:petstore/domain/usecase/cart/cart_checkout.dart';
import 'package:petstore/domain/usecase/cart/cart_get.dart';
import 'package:petstore/domain/usecase/cart/cart_remove.dart';
import 'package:petstore/presentation/cart/cubit/cart_cubit.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  late final CartCubit _cartCubit;

  @override
  void initState() {
    super.initState();
    _cartCubit = CartCubit(
      cartAdd: context.read<CartAdd>(),
      cartGet: context.read<CartGet>(),
      cartRemove: context.read<CartRemove>(),
      cartCheckout: context.read<CartCheckout>(),
    )..getCartPets();
  }

  @override
  void dispose() {
    _cartCubit.close();
    super.dispose();
  }

  void refreshCart() {
    _cartCubit.getCartPets();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cartCubit,
      child: const CartView(),
    );
  }
}

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  void _showCheckoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Checkout'),
        content: const Text('Are you sure you want to checkout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<CartCubit>().checkout();
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CartCubit, CartState>(
        listenWhen: (previous, current) =>
            previous.actionState != current.actionState,
        listener: (context, state) {
          if (state.actionState.status.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Action completed successfully'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.actionState.status.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.actionState.failure?.errorMessage ??
                      'Action failed',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
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
                      onPressed: () => context.read<CartCubit>().getCartPets(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (dataState.status.isSuccess) {
              final pets = dataState.data ?? [];

              if (pets.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your cart is empty',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
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
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context.read<CartCubit>().removeFromCart(pet.id);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _showCheckoutConfirmation(context),
                          child: Text('Checkout (${pets.length} items)'),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text('No data'));
          },
        ),
      ),
    );
  }
}
