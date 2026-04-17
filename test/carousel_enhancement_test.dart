import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laviade_store/widgets/carousel_section.dart';
import 'package:laviade_store/data/sample_products.dart';

void main() {
  group('Enhanced Carousel Item Builder Tests', () {
    testWidgets('Carousel displays with enhanced styling', (WidgetTester tester) async {
      // Build the carousel section
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.black,
            body: const CarouselSection(),
          ),
        ),
      );

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Verify carousel section is displayed
      expect(find.byType(CarouselSection), findsOneWidget);
      
      // Verify featured collection title is displayed
      expect(find.text('Featured Collection'), findsOneWidget);
      
      // Verify navigation controls are present
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
    });

    testWidgets('Enhanced carousel item builder creates proper styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.black,
            body: const CarouselSection(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify AnimatedContainer is used for enhanced styling
      expect(find.byType(AnimatedContainer), findsWidgets);
      
      // Verify ClipRRect is used for rounded corners
      expect(find.byType(ClipRRect), findsWidgets);
      
      // Verify Stack is used for overlay effects
      expect(find.byType(Stack), findsWidgets);
      
      // Verify enhanced styling elements are present
      expect(find.text('FEATURED'), findsOneWidget);
    });

    testWidgets('Enhanced carousel supports proper configuration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.black,
            body: const CarouselSection(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify carousel section displays properly
      expect(find.byType(CarouselSection), findsOneWidget);
      
      // Verify enhanced styling elements
      expect(find.text('FEATURED'), findsOneWidget);
      
      // Verify navigation controls work
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
    });

    test('Sample products have proper data for enhanced styling', () {
      final products = SampleProducts.getFeaturedProducts();
      
      // Verify we have the expected number of products
      expect(products.length, 4);
      
      // Verify each product has required fields for enhanced styling
      for (final product in products) {
        expect(product.id, isNotEmpty);
        expect(product.name, isNotEmpty);
        expect(product.price, isNotEmpty);
        expect(product.placeholderColor, isNotNull);
        expect(product.category, isNotEmpty);
      }
    });
  });
}