import 'package:flutter/material.dart';

/// Reusable confirmation dialog
/// Follows DRY principle
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Color? confirmColor;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onCancel,
    this.confirmColor,
  });

  /// Factory for delete confirmation
  factory ConfirmationDialog.delete({
    required String itemName,
    required VoidCallback onConfirm,
  }) {
    return ConfirmationDialog(
      title: 'Delete $itemName',
      message: 'Are you sure you want to delete $itemName?',
      confirmText: 'Delete',
      onConfirm: onConfirm,
      confirmColor: Colors.red,
    );
  }

  /// Factory for checkout confirmation
  factory ConfirmationDialog.checkout({
    required VoidCallback onConfirm,
  }) {
    return ConfirmationDialog(
      title: 'Checkout',
      message: 'Are you sure you want to checkout?',
      confirmText: 'Checkout',
      onConfirm: onConfirm,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(),
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          style: confirmColor != null
              ? ElevatedButton.styleFrom(backgroundColor: confirmColor)
              : null,
          child: Text(confirmText),
        ),
      ],
    );
  }

  /// Show the dialog
  static Future<void> show(
    BuildContext context,
    ConfirmationDialog dialog,
  ) {
    return showDialog(
      context: context,
      builder: (_) => dialog,
    );
  }
}
