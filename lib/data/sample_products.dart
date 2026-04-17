import 'package:flutter/material.dart';
import '../models/product_model.dart';

/// Sample product data for the Laviade Store app
/// Contains streetwear products with proper pricing and theme colors
class SampleProducts {
  /// List of featured products for carousel display
  static final List<ProductModel> featuredProducts = [
    ProductModel(
      id: 'hoodie-black-001',
      name: 'Essential Black Hoodie',
      price: 'Rp 299.000',
      placeholderColor: Colors.black,
      category: 'hoodie',
    ),
    ProductModel(
      id: 'tshirt-white-001',
      name: 'Classic White Tee',
      price: 'Rp 149.000',
      placeholderColor: Colors.white,
      category: 'tshirt',
    ),
    ProductModel(
      id: 'jacket-grey-001',
      name: 'Urban Grey Jacket',
      price: 'Rp 459.000',
      placeholderColor: Colors.grey[600]!,
      category: 'jacket',
    ),
    ProductModel(
      id: 'cargo-pants-001',
      name: 'Tactical Cargo Pants',
      price: 'Rp 329.000',
      placeholderColor: Colors.grey[800]!,
      category: 'cargo',
    ),
  ];

  /// List of all products for grid display
  static final List<ProductModel> allProducts = [
    ...featuredProducts,
    ProductModel(
      id: 'sneakers-white-001',
      name: 'Street Runner Sneakers',
      price: 'Rp 599.000',
      placeholderColor: Colors.grey[100]!,
      category: 'sneakers',
    ),
    ProductModel(
      id: 'cap-black-001',
      name: 'Minimalist Cap',
      price: 'Rp 99.000',
      placeholderColor: Colors.black,
      category: 'caps',
    ),
    ProductModel(
      id: 'bag-grey-001',
      name: 'Urban Backpack',
      price: 'Rp 399.000',
      placeholderColor: Colors.grey[700]!,
      category: 'bags',
    ),
    ProductModel(
      id: 'accessories-001',
      name: 'Chain Necklace',
      price: 'Rp 199.000',
      placeholderColor: Colors.grey[400]!,
      category: 'accessories',
    ),
  ];

  /// Get products by category
  static List<ProductModel> getProductsByCategory(String category) {
    return allProducts
        .where((product) => product.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  /// Get featured products (first 4 products)
  static List<ProductModel> getFeaturedProducts() {
    return featuredProducts;
  }

  /// Get random products for testing
  static List<ProductModel> getRandomProducts(int count) {
    final shuffled = List<ProductModel>.from(allProducts)..shuffle();
    return shuffled.take(count).toList();
  }
}