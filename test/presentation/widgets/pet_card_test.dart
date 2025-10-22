import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petstore/presentation/home/cubit/home_cubit.dart';
import 'package:petstore/presentation/home/widgets/pet_card.dart';
import '../../fixtures/pet_fixture.dart';

class MockHomeCubit extends Mock implements HomeCubit {}

void main() {
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
    when(() => mockHomeCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockHomeCubit.close()).thenAnswer((_) async {});
  });

  setUpAll(() {
    registerFallbackValue(PetFixture.testPet);
  });

  Widget createWidgetUnderTest() {
    return BlocProvider<HomeCubit>(
      create: (_) => mockHomeCubit,
      child: MaterialApp(
        home: Scaffold(
          body: PetCard(
            pet: PetFixture.testPet,
            onDeletePressed: () {},
          ),
        ),
      ),
    );
  }

  group('PetCard Widget Tests', () {
    testWidgets('displays pet information correctly', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.text('Test Dog'), findsOneWidget);
      expect(find.text('Category: Dogs'), findsOneWidget);
      expect(find.text('Status: available'), findsOneWidget);
    });

    testWidgets('displays pet tags', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.text('friendly'), findsOneWidget);
      expect(find.byType(Chip), findsOneWidget);
    });

    testWidgets('displays action buttons', (tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byIcon(Icons.add_shopping_cart), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });

    testWidgets('add to cart button calls cubit method', (tester) async {
      // arrange
      when(() => mockHomeCubit.addToCart(any())).thenAnswer((_) async {});

      // act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byIcon(Icons.add_shopping_cart));
      await tester.pumpAndSettle();

      // assert
      verify(() => mockHomeCubit.addToCart(PetFixture.testPet)).called(1);
    });

    testWidgets('delete button calls callback', (tester) async {
      // arrange
      bool deletePressed = false;

      // act
      await tester.pumpWidget(
        BlocProvider<HomeCubit>(
          create: (_) => mockHomeCubit,
          child: MaterialApp(
            home: Scaffold(
              body: PetCard(
                pet: PetFixture.testPet,
                onDeletePressed: () => deletePressed = true,
              ),
            ),
          ),
        ),
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
        BlocProvider<HomeCubit>(
          create: (_) => mockHomeCubit,
          child: MaterialApp(
            home: Scaffold(
              body: PetCard(
                pet: petWithoutPhoto,
                onDeletePressed: () {},
              ),
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
  });
}
