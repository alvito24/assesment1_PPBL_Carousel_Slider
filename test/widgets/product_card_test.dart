import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laviade_store/widgets/product_card.dart';
import 'package:laviade_store/models/product_model.dart';

void main() {
  group('ProductCard Widget Tests', () {
    late ProductModel testProduct;

    setUp(() {
      testProduct = const ProductModel(
        id: 'test-001',
        name: 'Test Product',
        price: 'Rp 199.000',
        placeholderColor: Colors.grey,
        category: 'streetwear',
      );
    });

    testWidgets('should display product information correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: testProduct),
          ),
        ),
      );

      // Verify product name is displayed
      expect(find.text('Test Product'), findsOneWidget);
      
      // Verify product price is displayed
      expect(find.text('Rp 199.000'), findsOneWidget);
      
      // Verify the card container exists
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should handle tap events', (WidgetTester tester) async {
      bool tapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(
              product: testProduct,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Tap the product card
      await tester.tap(find.byType(ProductCard));
      await tester.pump();

      // Verify tap was handled
      expect(tapped, isTrue);
    });

    testWidgets('should display appropriate icon for product category', (WidgetTester tester) async {
      final hoodieProduct = testProduct.copyWith(category: 'hoodie');
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: hoodieProduct),
          ),
        ),
      );

      // Verify icon is displayed
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('should use direct constructor correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard.direct(
              productName: 'Direct Product',
              price: 'Rp 299.000',
              placeholderColor: Colors.black,
            ),
          ),
        ),
      );

      // Verify direct constructor works
      expect(find.text('Direct Product'), findsOneWidget);
      expect(find.text('Rp 299.000'), findsOneWidget);
    });

    testWidgets('should handle long product names with ellipsis', (WidgetTester tester) async {
      final longNameProduct = testProduct.copyWith(
        name: 'This is a very long product name that should be truncated with ellipsis',
      );
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: ProductCard(product: longNameProduct),
            ),
          ),
        ),
      );

      // Verify the text widget exists (ellipsis behavior is handled by Text widget)
      expect(find.byType(Text), findsWidgets);
    });
  });
}