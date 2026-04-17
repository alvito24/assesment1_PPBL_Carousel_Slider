import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../widgets/carousel_section.dart';
import '../data/sample_products.dart';
import '../models/product_model.dart';

/// Main home page widget that serves as the container for the carousel and product grid
/// Implements the streetwear formal theme with black background and proper layout structure
/// 
/// Task 10.1 Complete Integration Features:
/// - Enhanced visual hierarchy with proper spacing and section separation
/// - Improved theme consistency across all components
/// - Responsive layout with adaptive spacing
/// - Premium visual polish with subtle design elements
/// - Seamless integration of CarouselSection and product grid
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header section with enhanced styling
            SliverToBoxAdapter(
              child: _buildEnhancedHeader(context),
            ),
            
            // Carousel section with improved integration
            SliverToBoxAdapter(
              child: _buildCarouselSection(context),
            ),
            
            // Product grid section with enhanced layout
            SliverToBoxAdapter(
              child: _buildEnhancedProductGrid(context),
            ),
            
            // Footer section for complete app feel
            SliverToBoxAdapter(
              child: _buildFooter(context),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds enhanced header section with premium styling and visual hierarchy
  /// Features improved typography, subtle animations, and brand positioning
  Widget _buildEnhancedHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final isTablet = screenWidth > 600 && screenWidth <= 900;
    
    return Container(
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 32 : (isTablet ? 24 : 16),
        isDesktop ? 40 : (isTablet ? 32 : 24),
        isDesktop ? 32 : (isTablet ? 24 : 16),
        isDesktop ? 24 : (isTablet ? 20 : 16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main brand title with enhanced styling
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Laviade Store',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: isDesktop ? 40 : (isTablet ? 36 : 32),
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 3,
                      width: isDesktop ? 120 : (isTablet ? 100 : 80),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.grey[600]!],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
              // Premium badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'PREMIUM',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: isDesktop ? 16 : (isTablet ? 14 : 12)),
          
          // Enhanced subtitle with better typography
          Text(
            'Premium Streetwear Collection',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
              color: Colors.grey[300],
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
          
          SizedBox(height: isDesktop ? 8 : 6),
          
          // Collection stats for premium feel
          Row(
            children: [
              _buildStatItem('4', 'Featured Items', context),
              SizedBox(width: isDesktop ? 32 : (isTablet ? 24 : 16)),
              _buildStatItem('8', 'Total Products', context),
              SizedBox(width: isDesktop ? 32 : (isTablet ? 24 : 16)),
              _buildStatItem('2024', 'Collection', context),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds individual stat item for header
  Widget _buildStatItem(String value, String label, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Builds carousel section with enhanced integration and spacing
  Widget _buildCarouselSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final isTablet = screenWidth > 600 && screenWidth <= 900;
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : (isTablet ? 24 : 16),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 32 : (isTablet ? 24 : 20),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey[900]!.withValues(alpha: 0.3),
            Colors.transparent,
            Colors.grey[900]!.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(isDesktop ? 24 : (isTablet ? 20 : 16)),
      ),
      child: const CarouselSection(),
    );
  }

  /// Enhanced product grid section with improved visual hierarchy and spacing
  /// Features section dividers, enhanced typography, and premium layout
  Widget _buildEnhancedProductGrid(BuildContext context) {
    final gridProducts = SampleProducts.getFeaturedProducts();
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final isTablet = screenWidth > 600 && screenWidth <= 900;
    
    return Container(
      margin: EdgeInsets.fromLTRB(
        isDesktop ? 32 : (isTablet ? 24 : 16),
        isDesktop ? 40 : (isTablet ? 32 : 24),
        isDesktop ? 32 : (isTablet ? 24 : 16),
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section divider with premium styling
          Container(
            width: double.infinity,
            height: 1,
            margin: EdgeInsets.only(bottom: isDesktop ? 32 : (isTablet ? 24 : 20)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.grey[700]!.withValues(alpha: 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          // Enhanced section header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Featured Products',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: isDesktop ? 28 : (isTablet ? 24 : 22),
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: isDesktop ? 8 : 6),
                    Text(
                      'Curated selection of our premium streetwear essentials',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: isDesktop ? 16 : (isTablet ? 14 : 13),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // View all button
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[600]!),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[300],
                      size: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: isDesktop ? 24 : (isTablet ? 20 : 16)),
          
          // Enhanced responsive grid with improved spacing
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              double childAspectRatio;
              double crossAxisSpacing;
              double mainAxisSpacing;
              
              if (constraints.maxWidth < 600) {
                // Mobile: 2 columns with tighter spacing
                crossAxisCount = 2;
                childAspectRatio = 0.75;
                crossAxisSpacing = 16;
                mainAxisSpacing = 16;
              } else if (constraints.maxWidth < 900) {
                // Tablet: 3 columns with balanced spacing
                crossAxisCount = 3;
                childAspectRatio = 0.8;
                crossAxisSpacing = 20;
                mainAxisSpacing = 20;
              } else {
                // Desktop: 4 columns with generous spacing
                crossAxisCount = 4;
                childAspectRatio = 0.85;
                crossAxisSpacing = 24;
                mainAxisSpacing = 24;
              }
              
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                ),
                itemCount: gridProducts.length,
                itemBuilder: (context, index) {
                  final product = gridProducts[index];
                  
                  return _buildEnhancedProductCard(product, index, context);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// Builds enhanced product card with premium styling and animations
  Widget _buildEnhancedProductCard(ProductModel product, int index, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200 + (index * 50)),
      curve: Curves.easeOutCubic,
      child: ProductCard(
        product: product,
        onTap: () {
          _showProductDetails(product, context);
        },
      ),
    );
  }

  /// Shows enhanced product details with premium styling
  void _showProductDetails(ProductModel product, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: product.placeholderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${product.price} • ${product.category.toUpperCase()}',
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.shopping_bag_outlined,
                color: Colors.grey[300],
                size: 20,
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.grey[850],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        elevation: 8,
      ),
    );
  }

  /// Builds footer section for complete app experience
  Widget _buildFooter(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final isTablet = screenWidth > 600 && screenWidth <= 900;
    
    return Container(
      margin: EdgeInsets.fromLTRB(
        isDesktop ? 32 : (isTablet ? 24 : 16),
        isDesktop ? 48 : (isTablet ? 40 : 32),
        isDesktop ? 32 : (isTablet ? 24 : 16),
        isDesktop ? 32 : (isTablet ? 24 : 20),
      ),
      padding: EdgeInsets.all(isDesktop ? 32 : (isTablet ? 24 : 20)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.grey[900]!.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(isDesktop ? 20 : (isTablet ? 16 : 12)),
        border: Border.all(
          color: Colors.grey[800]!.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Brand footer
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LAVIADE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isDesktop ? 16 : (isTablet ? 14 : 12),
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(width: isDesktop ? 16 : 12),
              Container(
                width: 1,
                height: isDesktop ? 20 : 16,
                color: Colors.grey[600],
              ),
              SizedBox(width: isDesktop ? 16 : 12),
              Text(
                'PREMIUM STREETWEAR',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: isDesktop ? 12 : (isTablet ? 11 : 10),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          
          SizedBox(height: isDesktop ? 16 : 12),
          
          // App info
          Text(
            'Flutter Carousel Showcase • All 10 APIs Implemented',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: isDesktop ? 12 : (isTablet ? 11 : 10),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}