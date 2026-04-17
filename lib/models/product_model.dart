import 'package:flutter/material.dart';

/// ProductModel represents a streetwear product in the Laviade Store app.
/// 
/// This model includes validation rules for all fields and supports the
/// streetwear e-commerce context with proper price formatting and theme colors.
class ProductModel {
  final String id;
  final String name;
  final String price;
  final Color placeholderColor;
  final String category;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.placeholderColor,
    required this.category,
  });

  /// Factory constructor for creating ProductModel from Map data.
  /// 
  /// Validates all input data and applies default values where appropriate.
  /// Throws [ArgumentError] if validation fails.
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    final id = map['id']?.toString() ?? '';
    final name = map['name']?.toString() ?? '';
    final price = map['price']?.toString() ?? '';
    final category = map['category']?.toString() ?? 'streetwear';
    
    // Handle color from map - can be Color object, int, or string
    Color placeholderColor = Colors.grey;
    if (map['color'] != null) {
      if (map['color'] is Color) {
        placeholderColor = map['color'];
      } else if (map['color'] is int) {
        placeholderColor = Color(map['color']);
      } else if (map['color'] is String) {
        placeholderColor = _parseColorFromString(map['color']);
      }
    }

    // Create instance with validation
    final product = ProductModel(
      id: id,
      name: name,
      price: price,
      placeholderColor: placeholderColor,
      category: category,
    );

    // Validate the created product
    product._validate();
    
    return product;
  }

  /// Validates all fields according to the design specifications.
  void _validate() {
    // ID validation
    if (id.isEmpty) {
      throw ArgumentError('Product ID cannot be empty');
    }

    // Name validation
    if (name.isEmpty) {
      throw ArgumentError('Product name cannot be empty');
    }
    if (name.length > 50) {
      throw ArgumentError('Product name cannot exceed 50 characters');
    }

    // Price validation - must follow "Rp XXX.XXX" format
    if (price.isEmpty) {
      throw ArgumentError('Product price cannot be empty');
    }
    if (!_isValidPriceFormat(price)) {
      throw ArgumentError('Price must follow "Rp XXX.XXX" format (e.g., "Rp 299.000")');
    }

    // PlaceholderColor validation - must be from approved theme palette
    if (!_isValidThemeColor(placeholderColor)) {
      throw ArgumentError('PlaceholderColor must be from approved theme palette (black, white, grey variants)');
    }

    // Category validation - must be valid streetwear category
    if (!_isValidStreetWearCategory(category)) {
      throw ArgumentError('Category must be a valid streetwear category');
    }
  }

  /// Validates price format according to Indonesian Rupiah format.
  bool _isValidPriceFormat(String price) {
    // Pattern: "Rp " followed by digits with optional dots for thousands separator
    final pricePattern = RegExp(r'^Rp \d{1,3}(?:\.\d{3})*$');
    return pricePattern.hasMatch(price);
  }

  /// Validates that the color is from the approved theme palette.
  bool _isValidThemeColor(Color color) {
    // Approved theme colors: black, white, grey variants
    final approvedColors = [
      Colors.black,
      Colors.white,
      Colors.grey,
      Colors.grey[100],
      Colors.grey[200],
      Colors.grey[300],
      Colors.grey[400],
      Colors.grey[500],
      Colors.grey[600],
      Colors.grey[700],
      Colors.grey[800],
      Colors.grey[900],
    ];

    return approvedColors.any((approvedColor) => 
      approvedColor != null && color == approvedColor);
  }

  /// Validates that the category is a valid streetwear category.
  bool _isValidStreetWearCategory(String category) {
    final validCategories = [
      'streetwear',
      'hoodie',
      'tshirt',
      't-shirt',
      'jacket',
      'pants',
      'cargo',
      'sneakers',
      'accessories',
      'caps',
      'bags',
    ];

    return validCategories.contains(category.toLowerCase());
  }

  /// Parses color from string representation.
  static Color _parseColorFromString(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'grey100':
        return Colors.grey[100]!;
      case 'grey200':
        return Colors.grey[200]!;
      case 'grey300':
        return Colors.grey[300]!;
      case 'grey400':
        return Colors.grey[400]!;
      case 'grey500':
        return Colors.grey[500]!;
      case 'grey600':
        return Colors.grey[600]!;
      case 'grey700':
        return Colors.grey[700]!;
      case 'grey800':
        return Colors.grey[800]!;
      case 'grey900':
        return Colors.grey[900]!;
      default:
        return Colors.grey;
    }
  }

  /// Converts the ProductModel to a Map for serialization.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'color': placeholderColor,
      'category': category,
    };
  }

  /// Creates a copy of this ProductModel with optionally updated fields.
  ProductModel copyWith({
    String? id,
    String? name,
    String? price,
    Color? placeholderColor,
    String? category,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      placeholderColor: placeholderColor ?? this.placeholderColor,
      category: category ?? this.category,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is ProductModel &&
      other.id == id &&
      other.name == name &&
      other.price == price &&
      other.placeholderColor == placeholderColor &&
      other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      placeholderColor.hashCode ^
      category.hashCode;
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, price: $price, placeholderColor: $placeholderColor, category: $category)';
  }
}