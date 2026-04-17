import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';
import '../models/product_model.dart';
import '../data/sample_products.dart';
import '../widgets/product_card.dart';
import '../widgets/carousel_indicator.dart';

/// CarouselSection is a StatefulWidget that implements complete carousel functionality 
/// with all 10 carousel_slider APIs configured for optimal streetwear e-commerce UX.
/// 
/// This widget manages:
/// - CarouselSliderController for manual navigation (API 4)
/// - Current page index tracking and state synchronization
/// - Product data display using ProductCard widgets
/// - All 10 carousel APIs with meaningful UX configurations:
///   - API 1: autoPlay (3-second intervals for engagement)
///   - API 2: enlargeCenterPage (focus on featured product)
///   - API 3: onPageChanged callback (state synchronization)
///   - API 4: CarouselController (manual navigation support)
///   - API 5: viewportFraction 0.8 (show adjacent items for context)
///   - API 6: enableInfiniteScroll (seamless browsing)
///   - API 7: autoPlayInterval 3s (optimal viewing time)
///   - API 8: autoPlayAnimationDuration 800ms (smooth premium feel)
///   - API 9: scrollDirection horizontal (standard e-commerce pattern)
///   - API 10: pauseAutoPlayOnTouch (respect user interaction)
class CarouselSection extends StatefulWidget {
  const CarouselSection({super.key});

  @override
  State<CarouselSection> createState() => _CarouselSectionState();
}

class _CarouselSectionState extends State<CarouselSection> {
  // CarouselController for manual navigation (API 4)
  late CarouselSliderController _carouselController;
    
  // Current page index for state management
  int _currentIndex = 0;
  
  // Product data for carousel items (4 streetwear items)
  late List<ProductModel> _carouselProducts;
  
  // Touch interaction state management
  bool _isUserInteracting = false;
  bool _autoPlayPaused = false;
  Timer? _resumeTimer;

  @override
  void initState() {
    super.initState();
    
    // Initialize CarouselController
    _carouselController = CarouselSliderController();
    
    // Get featured products for carousel (4 streetwear items)
    _carouselProducts = SampleProducts.getFeaturedProducts();
  }

  @override
  void dispose() {
    // Clean up resources
    _resumeTimer?.cancel();
    super.dispose();
  }

  /// Handles page change events from carousel (API 3: onPageChanged)
  void _handlePageChanged(int index, dynamic reason) {
    setState(() {
      _currentIndex = index;
    });
    
    // Track page change reason for analytics
    _logPageChangeReason(reason);
  }
  
  /// Logs page change reason for debugging and analytics
  void _logPageChangeReason(dynamic reason) {
    // In a real app, this would send analytics data
    debugPrint('Carousel page changed: reason=$reason, index=$_currentIndex');
  }
  
  /// Handles touch start - pauses auto-play and tracks interaction
  void _handleTouchStart() {
    setState(() {
      _isUserInteracting = true;
      _autoPlayPaused = true;
    });
    debugPrint('Touch interaction started - auto-play paused');
  }
  
  /// Handles touch end - schedules auto-play resume with delay
  void _handleTouchEnd() {
    setState(() {
      _isUserInteracting = false;
    });
    
    // Schedule auto-play resume after a delay to ensure smooth UX
    _scheduleAutoPlayResume();
    debugPrint('Touch interaction ended - scheduling auto-play resume');
  }
  
  /// Schedules auto-play resume with intelligent delay
  void _scheduleAutoPlayResume() {
    // Cancel any existing resume timer
    _resumeTimer?.cancel();
    
    _resumeTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted && !_isUserInteracting) {
        setState(() {
          _autoPlayPaused = false;
        });
        debugPrint('Auto-play resumed after touch interaction');
      }
    });
  }

  /// Navigate to specific page manually using CarouselController
  void _navigateToPage(int index) {
    if (index >= 0 && index < _carouselProducts.length) {
      // Pause auto-play during manual navigation
      _handleTouchStart();
      
      _carouselController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      
      // Schedule auto-play resume after navigation completes
      Future.delayed(const Duration(milliseconds: 800), () {
        _handleTouchEnd();
      });
    }
  }

  /// Navigate to next page using CarouselController
  void _nextPage() {
    // Pause auto-play during manual navigation
    _handleTouchStart();
    
    _carouselController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    
    // Schedule auto-play resume after navigation completes
    Future.delayed(const Duration(milliseconds: 800), () {
      _handleTouchEnd();
    });
  }

  /// Navigate to previous page using CarouselController
  void _previousPage() {
    // Pause auto-play during manual navigation
    _handleTouchStart();
    
    _carouselController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    
    // Schedule auto-play resume after navigation completes
    Future.delayed(const Duration(milliseconds: 800), () {
      _handleTouchEnd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Enhanced section title with premium styling
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Featured Collection',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Swipe through our curated streetwear essentials',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        
        // Carousel with all 10 APIs configured
        _buildCarouselSlider(),
        
        const SizedBox(height: 16),
        
        // Basic navigation controls foundation
        _buildNavigationControls(),
      ],
    );
  }

  /// Builds the CarouselSlider with all 10 APIs configured
  /// Enhanced with responsive height and improved scaling for center page effect
  /// Now includes sophisticated touch interaction handling
  Widget _buildCarouselSlider() {
    // Responsive carousel height based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    double carouselHeight;
    
    if (screenWidth < 600) {
      carouselHeight = 280; // Mobile - increased for better center page effect
    } else if (screenWidth < 900) {
      carouselHeight = 320; // Tablet - increased for better center page effect
    } else {
      carouselHeight = 360; // Desktop - increased for better center page effect
    }
    
    return Listener(
      // Enhanced touch interaction handling with Listener for better compatibility
      onPointerDown: (_) => _handleTouchStart(),
      onPointerUp: (_) => _handleTouchEnd(),
      onPointerCancel: (_) => _handleTouchEnd(),
      
      child: CarouselSlider.builder(
        carouselController: _carouselController,  // API 4: CarouselController
        options: CarouselOptions(
          autoPlay: !_autoPlayPaused,             // API 1: autoPlay - now controlled by touch state
          autoPlayInterval: const Duration(seconds: 3), // API 7: autoPlayInterval
          autoPlayAnimationDuration: const Duration(milliseconds: 800), // API 8: autoPlayAnimationDuration
          enlargeCenterPage: true,                // API 2: enlargeCenterPage
          enlargeFactor: 0.25,                   // Enhanced scaling factor for center page
          viewportFraction: 0.75,                // API 5: viewportFraction - adjusted for better center focus
          enableInfiniteScroll: true,            // API 6: enableInfiniteScroll
          scrollDirection: Axis.horizontal,      // API 9: scrollDirection
          pauseAutoPlayOnTouch: true,           // API 10: pauseAutoPlayOnTouch - enhanced with custom handling
          onPageChanged: _handlePageChanged,     // API 3: onPageChanged
          height: carouselHeight,
          // Enhanced animation curves for smoother transitions
          autoPlayCurve: Curves.easeInOutCubic,
          enlargeStrategy: CenterPageEnlargeStrategy.scale, // Better scaling strategy
        ),
        itemCount: _carouselProducts.length,
        itemBuilder: (context, index, realIndex) => _buildCarouselItem(index),
      ),
    );
  }

  /// Builds individual carousel item with enhanced styling and animations
  /// Features:
  /// - Enlarged center page effect with proper scaling
  /// - Smooth transitions and animations
  /// - Enhanced visual hierarchy with shadows and borders
  /// - Premium feel with gradient overlays
  Widget _buildCarouselItem(int index) {
    final product = _carouselProducts[index];
    final isCenter = index == _currentIndex;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: isCenter ? 0 : 16, // Center item takes full height
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: isCenter ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: product.placeholderColor.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ] : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Main product card
            ProductCard(
              product: product,
              onTap: () => _handleProductTap(product),
            ),
            
            // Enhanced center page overlay
            if (isCenter) _buildCenterPageOverlay(product),
            
            // Subtle gradient overlay for non-center items
            if (!isCenter) _buildNonCenterOverlay(),
            
            // Premium border for center item
            if (isCenter) _buildPremiumBorder(),
          ],
        ),
      ),
    );
  }

  /// Builds enhanced overlay for center page item
  Widget _buildCenterPageOverlay(ProductModel product) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.transparent,
              product.placeholderColor.withValues(alpha: 0.1),
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'FEATURED',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds subtle overlay for non-center items
  Widget _buildNonCenterOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.15),
        ),
      ),
    );
  }

  /// Builds premium border for center item
  Widget _buildPremiumBorder() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
      ),
    );
  }

  /// Handles product tap with enhanced feedback
  void _handleProductTap(ProductModel product) {
    // Add haptic feedback for premium feel
    // HapticFeedback.lightImpact(); // Uncomment if haptic feedback is desired
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: product.placeholderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${product.name} • ${product.price}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.grey[850],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Builds navigation controls with CarouselIndicator widget
  Widget _buildNavigationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous button
        IconButton(
          onPressed: _previousPage,
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey[800],
            shape: const CircleBorder(),
          ),
        ),
        
        const SizedBox(width: 24),
        
        // CarouselIndicator widget with tap functionality
        CarouselIndicator(
          currentIndex: _currentIndex,
          itemCount: _carouselProducts.length,
          onTap: _navigateToPage,
          dotSize: 12.0,
          spacing: 12.0,
          activeColor: Colors.white,
          inactiveColor: Colors.grey[600]!,
          animationDuration: const Duration(milliseconds: 300),
        ),
        
        const SizedBox(width: 24),
        
        // Next button
        IconButton(
          onPressed: _nextPage,
          icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey[800],
            shape: const CircleBorder(),
          ),
        ),
      ],
    );
  }
}