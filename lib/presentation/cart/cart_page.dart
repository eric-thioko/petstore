import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petstore/core/common/widgets/confirmation_dialog.dart';
import 'package:petstore/core/common/widgets/empty_state.dart';
import 'package:petstore/core/common/widgets/error_state.dart';
import 'package:petstore/core/common/widgets/loading_indicator.dart';
import 'package:petstore/core/di/service_locator.dart';
import 'package:petstore/domain/usecase/cart/cart_add.dart';
import 'package:petstore/domain/usecase/cart/cart_checkout.dart';
import 'package:petstore/domain/usecase/cart/cart_get.dart';
import 'package:petstore/domain/usecase/cart/cart_remove.dart';
import 'package:petstore/presentation/cart/cubit/cart_cubit.dart';
import 'package:petstore/presentation/cart/widgets/cart_item.dart';
import 'package:petstore/presentation/cart/widgets/checkout_button.dart';

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
      cartAdd: sl<CartAdd>(),
      cartGet: sl<CartGet>(),
      cartRemove: sl<CartRemove>(),
      cartCheckout: sl<CartCheckout>(),
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
      child: const _CartView(),
    );
  }
}

class _CartView extends StatelessWidget {
  const _CartView();

  void _showCheckoutConfirmation(BuildContext context) {
    ConfirmationDialog.show(
      context,
      ConfirmationDialog.checkout(
        onConfirm: () => context.read<CartCubit>().checkout(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CartCubit, CartState>(
        listenWhen: (previous, current) =>
            previous.actionState != current.actionState,
        listener: _handleActionStateChange,
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) => _buildBody(context, state),
        ),
      ),
    );
  }

  void _handleActionStateChange(BuildContext context, CartState state) {
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
            state.actionState.failure?.errorMessage ?? 'Action failed',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildBody(BuildContext context, CartState state) {
    final dataState = state.state;

    if (dataState.status.isLoading) {
      return const LoadingIndicator();
    }

    if (dataState.status.isError) {
      return ErrorState(
        message: dataState.failure?.errorMessage ?? 'An error occurred',
        onRetry: () => context.read<CartCubit>().getCartPets(),
      );
    }

    if (dataState.status.isSuccess) {
      final pets = dataState.data ?? [];

      if (pets.isEmpty) {
        return const EmptyState(
          icon: Icons.shopping_cart_outlined,
          message: 'Your cart is empty',
        );
      }

      return _buildCartList(context, pets);
    }

    return const EmptyState(
      icon: Icons.info_outline,
      message: 'No data',
    );
  }

  Widget _buildCartList(BuildContext context, List pets) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: pets.length,
            itemBuilder: (context, index) {
              final pet = pets[index];
              return CartItem(
                pet: pet,
                onDelete: () => context.read<CartCubit>().removeFromCart(pet.id),
              );
            },
          ),
        ),
        CheckoutButton(
          itemCount: pets.length,
          onPressed: () => _showCheckoutConfirmation(context),
        ),
      ],
    );
  }
}
