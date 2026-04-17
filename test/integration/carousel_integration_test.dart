import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laviade_store/widgets/carousel_section.dart';
import 'package:laviade_store/widgets/carousel_indicator.dart';

void main() {
  group('Carousel Integration Tests', () {
    testWidgets('CarouselSection should contain CarouselIndicator widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CarouselSection(),
          ),
        ),
      );

      // Wait for the carousel to initialize
      await tester.pumpAndSettle();

      // Verify that CarouselIndicator is present
      expect(find.byType(CarouselIndicator), findsOneWidget);
      
      // Verify that navigation buttons are present
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
    });

    testWidgets('CarouselIndicator should respond to taps in CarouselSection', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CarouselSection(),
          ),
        ),
      );

      // Wait for the carousel to initialize
      await tester.pumpAndSettle();

      // Find the CarouselIndicator
      final indicatorFinder = find.byType(CarouselIndicator);
      expect(indicatorFinder, findsOneWidget);

      // Find all gesture detectors within the indicator (the dots)
      final dotFinders = find.descendant(
        of: indicatorFinder,
        matching: find.byType(GestureDetector),
      );

      // Should have 4 dots for the 4 featured products
      expect(dotFinders, findsNWidgets(4));

      // Tap the second dot (index 1)
      await tester.tap(dotFinders.at(1));
      await tester.pumpAndSettle();

      // The carousel should have navigated to the second item
      // We can verify this by checking if the state display shows the correct index
      expect(find.textContaining('Current Index: 1'), findsOneWidget);
    });

    testWidgets('Navigation buttons should work with CarouselIndicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CarouselSection(),
          ),
        ),
      );

      // Wait for the carousel to initialize
      await tester.pumpAndSettle();

      // Initially should be at index 0
      expect(find.textContaining('Current Index: 0'), findsOneWidget);

      // Tap the next button
      await tester.tap(find.byIcon(Icons.arrow_forward_ios));
      await tester.pumpAndSettle();

      // Should now be at index 1
      expect(find.textContaining('Current Index: 1'), findsOneWidget);

      // Tap the previous button
      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pumpAndSettle();

      // Should be back at index 0
      expect(find.textContaining('Current Index: 0'), findsOneWidget);
    });
  });
}