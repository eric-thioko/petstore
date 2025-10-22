import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petstore/core/common/widgets/confirmation_dialog.dart';

void main() {
  group('ConfirmationDialog Widget Tests', () {
    testWidgets('displays dialog with custom content', (tester) async {
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  ConfirmationDialog.show(
                    context,
                    ConfirmationDialog(
                      title: 'Test Title',
                      message: 'Test Message',
                      onConfirm: () {},
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // assert
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Message'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('delete factory creates correct dialog', (tester) async {
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  ConfirmationDialog.show(
                    context,
                    ConfirmationDialog.delete(
                      itemName: 'Test Pet',
                      onConfirm: () {},
                    ),
                  );
                },
                child: const Text('Show Delete Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Delete Dialog'));
      await tester.pumpAndSettle();

      // assert
      expect(find.text('Delete Test Pet'), findsOneWidget);
      expect(find.text('Are you sure you want to delete Test Pet?'),
          findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('checkout factory creates correct dialog', (tester) async {
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  ConfirmationDialog.show(
                    context,
                    ConfirmationDialog.checkout(
                      onConfirm: () {},
                    ),
                  );
                },
                child: const Text('Show Checkout Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Checkout Dialog'));
      await tester.pumpAndSettle();

      // assert
      expect(find.text('Checkout'), findsNWidgets(2)); // Title and button
      expect(find.text('Are you sure you want to checkout?'), findsOneWidget);
    });

    testWidgets('confirm button calls onConfirm callback', (tester) async {
      // arrange
      bool confirmed = false;

      // act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  ConfirmationDialog.show(
                    context,
                    ConfirmationDialog(
                      title: 'Test',
                      message: 'Test',
                      onConfirm: () => confirmed = true,
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      // assert
      expect(confirmed, true);
      expect(find.byType(AlertDialog), findsNothing); // Dialog should close
    });

    testWidgets('cancel button closes dialog without confirming',
        (tester) async {
      // arrange
      bool confirmed = false;

      // act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  ConfirmationDialog.show(
                    context,
                    ConfirmationDialog(
                      title: 'Test',
                      message: 'Test',
                      onConfirm: () => confirmed = true,
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // assert
      expect(confirmed, false);
      expect(find.byType(AlertDialog), findsNothing); // Dialog should close
    });

    testWidgets('delete dialog has red confirm button', (tester) async {
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  ConfirmationDialog.show(
                    context,
                    ConfirmationDialog.delete(
                      itemName: 'Test',
                      onConfirm: () {},
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // assert
      final deleteButton =
          tester.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, 'Delete'));
      expect(deleteButton.style?.backgroundColor?.resolve({}), Colors.red);
    });
  });
}
