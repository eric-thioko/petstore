import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  final int itemCount;
  final VoidCallback onPressed;

  const CheckoutButton({
    super.key,
    required this.itemCount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text('Checkout ($itemCount items)'),
          ),
        ),
      ),
    );
  }
}
