import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petstore/core/common/widgets/loading_indicator.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: Scaffold(
        body: LoadingIndicator(),
      ),
    );
  }

  group('LoadingIndicator Widget Tests', () {
    testWidgets('displays CircularProgressIndicator', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('centers content on screen', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('CircularProgressIndicator is inside Center', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      final centerWidget = find.byType(Center);
      final progressIndicator = find.byType(CircularProgressIndicator);

      expect(centerWidget, findsOneWidget);
      expect(progressIndicator, findsOneWidget);

      // Verify CircularProgressIndicator is descendant of Center
      expect(
        find.descendant(
          of: centerWidget,
          matching: progressIndicator,
        ),
        findsOneWidget,
      );
    });

    testWidgets('displays correctly in multiple contexts', (tester) async {
      // Test in Column
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                LoadingIndicator(),
              ],
            ),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Test in Stack
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: const [
                LoadingIndicator(),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('is visible and not hidden', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progressIndicator, isNotNull);
    });

    testWidgets('animates properly', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // Let animation run
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('can be used multiple times in same widget tree',
        (tester) async {
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                LoadingIndicator(),
                SizedBox(height: 20),
                LoadingIndicator(),
              ],
            ),
          ),
        ),
      );

      // assert
      expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
    });

    testWidgets('widget can be created as const', (tester) async {
      // act & assert - Widget should be creatable as const
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingIndicator(),
          ),
        ),
      );

      expect(find.byType(LoadingIndicator), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
