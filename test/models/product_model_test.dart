import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laviade_store/models/product_model.dart';

void main() {
  group('ProductModel', () {
    test('should create ProductModel with valid data', () {
      const product = ProductModel(
        id: 'prod_001',
        name: 'Streetwear Hoodie',
        price: 'Rp 299.000',
        placeholderColor: Colors.black,
        category: 'hoodie',
      );

      expect(product.id, 'prod_001');
      expect(product.name, 'Streetwear Hoodie');
      expect(product.price, 'Rp 299.000');
      expect(product.placeholderColor, Colors.black);
      expect(product.category, 'hoodie');
    });

    test('should create ProductModel from Map with valid data', () {
      final map = {
        'id': 'prod_002',
        'name': 'White T-Shirt',
        'price': 'Rp 149.000',
        'color': Colors.white,
        'category': 'tshirt',
      };

      final product = ProductModel.fromMap(map);

      expect(product.id, 'prod_002');
      expect(product.name, 'White T-Shirt');
      expect(product.price, 'Rp 149.000');
      expect(product.placeholderColor, Colors.white);
      expect(product.category, 'tshirt');
    });

    test('should throw ArgumentError for empty id', () {
      expect(
        () => ProductModel.fromMap({
          'id': '',
          'name': 'Test Product',
          'price': 'Rp 100.000',
          'color': Colors.grey,
          'category': 'streetwear',
        }),
        throwsArgumentError,
      );
    });

    test('should throw ArgumentError for invalid price format', () {
      expect(
        () => ProductModel.fromMap({
          'id': 'prod_003',
          'name': 'Test Product',
          'price': '100000', // Invalid format
          'color': Colors.grey,
          'category': 'streetwear',
        }),
        throwsArgumentError,
      );
    });

    test('should accept valid price formats', () {
      final validPrices = [
        'Rp 100.000',
        'Rp 1.500.000',
        'Rp 50.000',
        'Rp 999.999',
      ];

      for (final price in validPrices) {
        expect(
          () => ProductModel.fromMap({
            'id': 'test_id',
            'name': 'Test Product',
            'price': price,
            'color': Colors.grey,
            'category': 'streetwear',
          }),
          returnsNormally,
        );
      }
    });

    test('should convert to Map correctly', () {
      const product = ProductModel(
        id: 'prod_004',
        name: 'Grey Jacket',
        price: 'Rp 450.000',
        placeholderColor: Colors.grey,
        category: 'jacket',
      );

      final map = product.toMap();

      expect(map['id'], 'prod_004');
      expect(map['name'], 'Grey Jacket');
      expect(map['price'], 'Rp 450.000');
      expect(map['color'], Colors.grey);
      expect(map['category'], 'jacket');
    });

    test('should create copy with updated fields', () {
      const original = ProductModel(
        id: 'prod_005',
        name: 'Original Product',
        price: 'Rp 200.000',
        placeholderColor: Colors.black,
        category: 'streetwear',
      );

      final copy = original.copyWith(
        name: 'Updated Product',
        price: 'Rp 250.000',
      );

      expect(copy.id, 'prod_005'); // Unchanged
      expect(copy.name, 'Updated Product'); // Changed
      expect(copy.price, 'Rp 250.000'); // Changed
      expect(copy.placeholderColor, Colors.black); // Unchanged
      expect(copy.category, 'streetwear'); // Unchanged
    });
  });
}