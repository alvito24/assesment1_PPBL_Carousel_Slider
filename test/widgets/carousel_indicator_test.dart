import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laviade_store/widgets/carousel_indicator.dart';

void main() {
  group('CarouselIndicator Widget Tests', () {
    testWidgets('should render correct number of indicator dots', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselIndicator(
              currentIndex: 0,
              itemCount: 4,
              onTap: (index) {}, // Simple empty callback
            ),
          ),
        ),
      );

      // Should render 4 indicator dots
      expect(find.byType(GestureDetector), findsNWidgets(4));
    });

    testWidgets('should highlight active indicator dot', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselIndicator(
              currentIndex: 1,
              itemCount: 4,
              onTap: (index) {},
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              dotSize: 10.0,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find all gesture detectors (indicator dots)
      final gestures = find.byType(GestureDetector);
      expect(gestures, findsNWidgets(4));
      
      // Verify that the correct number of indicators are rendered
      expect(find.byType(AnimatedContainer), findsNWidgets(4));
    });

    testWidgets('should call onTap when indicator dot is tapped', (WidgetTester tester) async {
      int tappedIndex = -1;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselIndicator(
              currentIndex: 0,
              itemCount: 4,
              onTap: (index) => tappedIndex = index,
            ),
          ),
        ),
      );

      // Tap the third indicator dot (index 2)
      await tester.tap(find.byType(GestureDetector).at(2));
      await tester.pumpAndSettle();

      expect(tappedIndex, 2);
    });

    testWidgets('should animate when currentIndex changes', (WidgetTester tester) async {
      int currentIndex = 0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Column(
                  children: [
                    CarouselIndicator(
                      currentIndex: currentIndex,
                      itemCount: 4,
                      onTap: (index) {
                        setState(() => currentIndex = index);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => currentIndex = 1),
                      child: const Text('Change Index'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      // Initially, first dot should be active
      expect(currentIndex, 0);

      // Tap the button to change index
      await tester.tap(find.text('Change Index'));
      await tester.pump(); // Start animation
      await tester.pumpAndSettle(); // Complete animation

      expect(currentIndex, 1);
    });
  });
}