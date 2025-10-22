import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petstore/presentation/cart/widgets/cart_item.dart';
import '../../../fixtures/pet_fixture.dart';

void main() {
  Widget createWidgetUnderTest({VoidCallback? onDelete}) {
    return MaterialApp(
      home: Scaffold(
        body: CartItem(
          pet: PetFixture.testPet,
          onDelete: onDelete ?? () {},
        ),
      ),
    );
  }

  group('CartItem Widget Tests', () {
    testWidgets('displays pet information correctly', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.text('Test Dog'), findsOneWidget);
      expect(find.text('Category: Dogs'), findsOneWidget);
      expect(find.text('Status: available'), findsOneWidget);
    });

    testWidgets('displays delete button', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byIcon(Icons.delete), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('delete button calls callback when pressed', (tester) async {
      // arrange
      bool deletePressed = false;

      // act
      await tester.pumpWidget(
        createWidgetUnderTest(onDelete: () => deletePressed = true),
      );
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      // assert
      expect(deletePressed, true);
    });

    testWidgets('displays pet icon when no photo URL', (tester) async {
      // arrange
      final petWithoutPhoto = PetFixture.testPet.copyWith(photoUrls: []);

      // act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CartItem(
              pet: petWithoutPhoto,
              onDelete: () {},
            ),
          ),
        ),
      );

      // assert
      expect(find.byIcon(Icons.pets), findsOneWidget);
    });

    testWidgets('card is displayed as Card widget', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
    });


    testWidgets('displays trailing delete button in correct position',
        (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.trailing, isNotNull);
    });
  });
}
