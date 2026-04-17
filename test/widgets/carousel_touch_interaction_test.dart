import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laviade_store/widgets/carousel_section.dart';

void main() {
  group('Carousel Touch Interaction Tests', () {
    testWidgets('Touch interaction should pause auto-play', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CarouselSection(),
          ),
        ),
      );

      // Wait for the carousel to initialize
      await tester.pumpAndSettle();

      // Initially auto-play should be active
      expect(find.textContaining('ACTIVE'), findsOneWidget);
      expect(find.textContaining('PAUSED'), findsNothing);

      // Find the carousel and tap it
      final carouselFinder = find.byType(CarouselSection);
      await tester.tap(carouselFinder);
      await tester.pump();

      // Auto-play should now be paused
      expect(find.textContaining('PAUSED'), findsOneWidget);
    });

    testWidgets('Auto-play should resume after touch interaction ends', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CarouselSection(),
          ),
        ),
      );

      // Wait for the carousel to initialize
      await tester.pumpAndSettle();

      // Initially auto-play should be active
      expect(find.textContaining('ACTIVE'), findsOneWidget);

      // Tap the carousel to pause auto-play
      final carouselFinder = find.byType(CarouselSection);
      await tester.tap(carouselFinder);
      await tester.pump();

      // Auto-play should be paused
      expect(find.textContaining('PAUSED'), findsOneWidget);

      // Wait for auto-play resume delay (1.5 seconds + buffer)
      await tester.pump(const Duration(seconds: 2));

      // Auto-play should resume
      expect(find.textContaining('ACTIVE'), findsOneWidget);
    });

    testWidgets('Manual navigation should pause and resume auto-play', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CarouselSection(),
          ),
        ),
      );

      // Wait for the carousel to initialize
      await tester.pumpAndSettle();

      // Initially auto-play should be active
      expect(find.textContaining('ACTIVE'), findsOneWidget);

      // Tap the next button
      await tester.tap(find.byIcon(Icons.arrow_forward_ios));
      await tester.pump();

      // Auto-play should be paused during manual navigation
      expect(find.textContaining('PAUSED'), findsOneWidget);

      // Wait for navigation completion and auto-play resume
      await tester.pump(const Duration(seconds: 2));

      // Auto-play should resume
      expect(find.textContaining('ACTIVE'), findsOneWidget);
    });

    testWidgets('Carousel built-in swipe should work with enhanced touch handling', (WidgetTester tester) async {
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

      // Find the carousel widget and perform a drag (using carousel's built-in functionality)
      final carouselFinder = find.byType(CarouselSection);
      await tester.drag(carouselFinder, const Offset(-200, 0));
      
      // Don't wait for settle to avoid timer issues, just pump once
      await tester.pump();

      // The carousel should have detected touch interaction
      expect(find.textContaining('PAUSED'), findsOneWidget);
    });

    testWidgets('Multiple rapid touches should handle state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CarouselSection(),
          ),
        ),
      );

      // Wait for the carousel to initialize
      await tester.pumpAndSettle();

      final carouselFinder = find.byType(CarouselSection);

      // Perform multiple rapid touches
      for (int i = 0; i < 3; i++) {
        await tester.tap(carouselFinder);
        await tester.pump(const Duration(milliseconds: 100));
      }

      // Auto-play should be paused
      expect(find.textContaining('PAUSED'), findsOneWidget);

      // Wait for auto-play resume
      await tester.pump(const Duration(seconds: 2));

      // Auto-play should resume correctly
      expect(find.textContaining('ACTIVE'), findsOneWidget);
    });

    testWidgets('Touch interaction state should be tracked correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CarouselSection(),
          ),
        ),
      );

      // Wait for the carousel to initialize
      await tester.pumpAndSettle();

      final carouselFinder = find.byType(CarouselSection);

      // Start touch interaction
      await tester.tap(carouselFinder);
      await tester.pump();

      // Auto-play should be paused (this is the key indicator of touch interaction)
      expect(find.textContaining('PAUSED'), findsOneWidget);

      // Wait for interaction to end
      await tester.pump(const Duration(seconds: 2));

      // Auto-play should resume
      expect(find.textContaining('ACTIVE'), findsOneWidget);
    });

    testWidgets('Enhanced touch handling should work with navigation buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CarouselSection(),
          ),
        ),
      );

      // Wait for the carousel to initialize
      await tester.pumpAndSettle();

      // Initially auto-play should be active
      expect(find.textContaining('ACTIVE'), findsOneWidget);

      // Tap the previous button
      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pump();

      // Auto-play should be paused during manual navigation
      expect(find.textContaining('PAUSED'), findsOneWidget);

      // Wait for navigation completion and auto-play resume
      await tester.pump(const Duration(seconds: 2));

      // Auto-play should resume
      expect(find.textContaining('ACTIVE'), findsOneWidget);
    });

    testWidgets('Touch interaction should work with carousel state display', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CarouselSection(),
          ),
        ),
      );

      // Wait for the carousel to initialize
      await tester.pumpAndSettle();

      // Verify enhanced touch handling is mentioned in status
      expect(find.textContaining('Enhanced Touch'), findsOneWidget);
      expect(find.textContaining('Smart auto-play resume'), findsOneWidget);

      // Verify initial state
      expect(find.textContaining('Current Index: 0'), findsOneWidget);
      expect(find.textContaining('ACTIVE'), findsOneWidget);
    });
  });
}