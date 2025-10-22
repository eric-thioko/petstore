import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petstore/presentation/cart/widgets/checkout_button.dart';

void main() {
  Widget createWidgetUnderTest({
    required int itemCount,
    VoidCallback? onPressed,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: CheckoutButton(
          itemCount: itemCount,
          onPressed: onPressed ?? () {},
        ),
      ),
    );
  }

  group('CheckoutButton Widget Tests', () {
    testWidgets('displays correct text with item count', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest(itemCount: 3));

      // assert
      expect(find.text('Checkout (3 items)'), findsOneWidget);
    });

    testWidgets('displays singular "item" when count is 1', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest(itemCount: 1));

      // assert
      expect(find.text('Checkout (1 item)'), findsOneWidget);
    });

    testWidgets('button calls callback when pressed', (tester) async {
      // arrange
      bool buttonPressed = false;

      // act
      await tester.pumpWidget(
        createWidgetUnderTest(
          itemCount: 2,
          onPressed: () => buttonPressed = true,
        ),
      );
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // assert
      expect(buttonPressed, true);
    });

    testWidgets('displays as ElevatedButton', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest(itemCount: 5));

      // assert
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('button takes full width', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest(itemCount: 2));

      // assert
      final button = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(ElevatedButton),
          matching: find.byType(SizedBox),
        ),
      );
      expect(button.width, double.infinity);
    });

    testWidgets('displays with correct styling', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest(itemCount: 2));

      // assert
      final elevatedButton =
          tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(elevatedButton.onPressed, isNotNull);
      expect(elevatedButton.child, isA<Text>());
    });

    testWidgets('handles zero items', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest(itemCount: 0));

      // assert
      expect(find.text('Checkout (0 items)'), findsOneWidget);
    });

    testWidgets('handles large item count', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest(itemCount: 100));

      // assert
      expect(find.text('Checkout (100 items)'), findsOneWidget);
    });
  });
}
