// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:laviade_store/main.dart';

void main() {
  testWidgets('Laviade Store app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LaviadeStoreApp());

    // Verify that the app title is displayed.
    expect(find.text('Laviade Store'), findsOneWidget);
    expect(find.text('Premium Streetwear Collection'), findsOneWidget);
    
    // Verify that carousel section is displayed with foundation.
    expect(find.text('Featured Collection'), findsOneWidget);
    expect(find.text('Carousel Status: All 10 APIs Configured + Enhanced Touch'), findsOneWidget);
    expect(find.text('Featured Products'), findsOneWidget);
    
    // Verify that product cards are displayed (basic structure is complete)
    // Note: Products appear in both carousel and grid, so we expect multiple instances
    expect(find.text('Essential Black Hoodie'), findsWidgets);
    expect(find.text('Classic White Tee'), findsWidgets);
  });
}
