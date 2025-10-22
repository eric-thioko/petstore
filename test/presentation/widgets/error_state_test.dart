import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petstore/core/common/widgets/error_state.dart';

void main() {
  Widget createWidgetUnderTest({
    required String message,
    VoidCallback? onRetry,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: ErrorState(
          message: message,
          onRetry: onRetry ?? () {},
        ),
      ),
    );
  }

  group('ErrorState Widget Tests', () {
    testWidgets('displays error icon', (tester) async {
      // act
      await tester.pumpWidget(
        createWidgetUnderTest(message: 'An error occurred'),
      );

      // assert
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('displays error message correctly', (tester) async {
      // act
      await tester.pumpWidget(
        createWidgetUnderTest(message: 'Network error occurred'),
      );

      // assert
      expect(find.text('Network error occurred'), findsOneWidget);
    });

    testWidgets('displays retry button', (tester) async {
      // act
      await tester.pumpWidget(
        createWidgetUnderTest(message: 'Error'),
      );

      // assert
      expect(find.text('Retry'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('retry button calls callback when pressed', (tester) async {
      // arrange
      bool retryPressed = false;

      // act
      await tester.pumpWidget(
        createWidgetUnderTest(
          message: 'Failed to load',
          onRetry: () => retryPressed = true,
        ),
      );
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();

      // assert
      expect(retryPressed, true);
    });

    testWidgets('displays content in column layout', (tester) async {
      // act
      await tester.pumpWidget(
        createWidgetUnderTest(message: 'Something went wrong'),
      );

      // assert
      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('icon is displayed above message and button', (tester) async {
      // act
      await tester.pumpWidget(
        createWidgetUnderTest(message: 'Error occurred'),
      );

      // assert
      final column = tester.widget<Column>(find.byType(Column));
      expect(column.children.length, 5);
      expect(column.children[0], isA<Icon>());
      expect(column.children[1], isA<SizedBox>());
      expect(column.children[2], isA<Text>());
      expect(column.children[3], isA<SizedBox>());
      expect(column.children[4], isA<ElevatedButton>());
    });

    testWidgets('handles long error messages', (tester) async {
      // act
      const longMessage =
          'This is a very long error message that explains in detail what went wrong and how the user might be able to fix it';
      await tester.pumpWidget(
        createWidgetUnderTest(message: longMessage),
      );

      // assert
      expect(find.text(longMessage), findsOneWidget);
    });

    testWidgets('displays different error messages', (tester) async {
      // Test network error
      await tester.pumpWidget(
        createWidgetUnderTest(message: 'Network error'),
      );
      expect(find.text('Network error'), findsOneWidget);

      // Test server error
      await tester.pumpWidget(
        createWidgetUnderTest(message: 'Server error'),
      );
      await tester.pumpAndSettle();
      expect(find.text('Server error'), findsOneWidget);
    });

    testWidgets('retry button is tappable', (tester) async {
      // arrange
      int tapCount = 0;

      // act
      await tester.pumpWidget(
        createWidgetUnderTest(
          message: 'Error',
          onRetry: () => tapCount++,
        ),
      );

      // Tap multiple times
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();

      // assert
      expect(tapCount, 2);
    });

    testWidgets('displays with proper spacing and alignment', (tester) async {
      // act
      await tester.pumpWidget(
        createWidgetUnderTest(message: 'Error'),
      );

      // assert
      final column = tester.widget<Column>(find.byType(Column));
      expect(column.mainAxisAlignment, MainAxisAlignment.center);
    });
  });
}
