import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petstore/core/common/widgets/empty_state.dart';

void main() {
  Widget createWidgetUnderTest({
    required IconData icon,
    required String message,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: EmptyState(
          icon: icon,
          message: message,
        ),
      ),
    );
  }

  group('EmptyState Widget Tests', () {
    testWidgets('displays icon correctly', (tester) async {
      // act
      await tester.pumpWidget(
        createWidgetUnderTest(
          icon: Icons.shopping_cart,
          message: 'Test message',
        ),
      );

      // assert
      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    });

    testWidgets('displays message correctly', (tester) async {
      // act
      await tester.pumpWidget(
        createWidgetUnderTest(
          icon: Icons.pets,
          message: 'No pets available',
        ),
      );

      // assert
      expect(find.text('No pets available'), findsOneWidget);
    });

    testWidgets('displays with different icons', (tester) async {
      // Test with pets icon
      await tester.pumpWidget(
        createWidgetUnderTest(
          icon: Icons.pets,
          message: 'No pets',
        ),
      );
      expect(find.byIcon(Icons.pets), findsOneWidget);

      // Test with cart icon
      await tester.pumpWidget(
        createWidgetUnderTest(
          icon: Icons.shopping_cart_outlined,
          message: 'Empty cart',
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    });

    testWidgets('displays content in column layout', (tester) async {
      // act
      await tester.pumpWidget(
        createWidgetUnderTest(
          icon: Icons.error_outline,
          message: 'No data',
        ),
      );

      // assert
      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('icon is displayed above message', (tester) async {
      // act
      await tester.pumpWidget(
        createWidgetUnderTest(
          icon: Icons.inbox,
          message: 'Empty inbox',
        ),
      );

      // assert
      final column = tester.widget<Column>(find.byType(Column));
      expect(column.children.length, 3);
      expect(column.children[0], isA<Icon>());
      expect(column.children[1], isA<SizedBox>());
      expect(column.children[2], isA<Text>());
    });

    testWidgets('handles long message text', (tester) async {
      // act
      await tester.pumpWidget(
        createWidgetUnderTest(
          icon: Icons.warning,
          message:
              'This is a very long message that should be displayed properly without any issues',
        ),
      );

      // assert
      expect(
        find.text(
          'This is a very long message that should be displayed properly without any issues',
        ),
        findsOneWidget,
      );
    });

    testWidgets('displays with proper spacing', (tester) async {
      // act
      await tester.pumpWidget(
        createWidgetUnderTest(
          icon: Icons.check_circle_outline,
          message: 'All done',
        ),
      );

      // assert
      final column = tester.widget<Column>(find.byType(Column));
      expect(column.mainAxisAlignment, MainAxisAlignment.center);
    });
  });
}
