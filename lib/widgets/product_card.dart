import 'package:flutter/material.dart';
import '../models/product_model.dart';

/// ProductCard is a reusable widget for displaying individual product information
/// with streetwear formal styling (black/white/grey theme).
/// 
/// This component displays:
/// - Product placeholder image with themed colors
/// - Product name with consistent typography
/// - Product price with proper formatting
/// - Consistent spacing and layout following design specifications
class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.width,
    this.height,
  });

  /// Alternative constructor for direct property specification
  /// (maintains backward compatibility with design interface)
  ProductCard.direct({
    super.key,
    required String productName,
    required String price,
    required Color placeholderColor,
    this.onTap,
    this.width,
    this.height,
  }) : product = ProductModel(
          id: 'direct',
          name: productName,
          price: price,
          placeholderColor: placeholderColor,
          category: 'streetwear',
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product placeholder image
            Expanded(
              flex: 3,
              child: _buildProductImage(context),
            ),
            
            // Product information section
            Expanded(
              flex: 2,
              child: _buildProductInfo(context),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the product placeholder image with themed colors
  /// Enhanced for responsive design with adaptive icon sizing
  Widget _buildProductImage(BuildContext context) {
    // Responsive icon size based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    double iconSize;
    
    if (screenWidth < 600) {
      iconSize = 40; // Mobile
    } else if (screenWidth < 900) {
      iconSize = 48; // Tablet
    } else {
      iconSize = 56; // Desktop
    }
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: product.placeholderColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Center(
        child: Icon(
          _getProductIcon(),
          size: iconSize,
          color: _getIconColor(),
        ),
      ),
    );
  }

  /// Builds the product information section with name and price
  /// Enhanced for responsive design with adaptive typography
  Widget _buildProductInfo(BuildContext context) {
    // Responsive font sizes based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    double nameFontSize;
    double priceFontSize;
    double padding;
    
    if (screenWidth < 600) {
      // Mobile
      nameFontSize = 13;
      priceFontSize = 11;
      padding = 10;
    } else if (screenWidth < 900) {
      // Tablet
      nameFontSize = 14;
      priceFontSize = 12;
      padding = 12;
    } else {
      // Desktop
      nameFontSize = 15;
      priceFontSize = 13;
      padding = 14;
    }
    
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Product name with responsive typography
          Text(
            product.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: nameFontSize,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 4),
          
          // Product price with responsive typography
          Text(
            product.price,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: priceFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Returns appropriate icon based on product category
  IconData _getProductIcon() {
    switch (product.category.toLowerCase()) {
      case 'hoodie':
        return Icons.checkroom;
      case 'tshirt':
      case 't-shirt':
        return Icons.dry_cleaning;
      case 'jacket':
        return Icons.checkroom_outlined;
      case 'pants':
      case 'cargo':
        return Icons.content_cut;
      case 'sneakers':
        return Icons.sports_tennis;
      case 'accessories':
        return Icons.watch;
      case 'caps':
        return Icons.sports_baseball;
      case 'bags':
        return Icons.shopping_bag;
      default:
        return Icons.shopping_bag_outlined;
    }
  }

  /// Returns appropriate icon color based on placeholder background
  Color _getIconColor() {
    // Calculate luminance to determine if background is light or dark
    final luminance = product.placeholderColor.computeLuminance();
    
    // Use dark icon on light backgrounds, light icon on dark backgrounds
    return luminance > 0.5 ? Colors.black87 : Colors.white70;
  }
}