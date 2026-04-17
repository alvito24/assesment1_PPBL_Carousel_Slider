import 'package:flutter/material.dart';

/// Configuration class for carousel functionality with all 10 carousel_slider APIs
/// Optimized for streetwear e-commerce user experience with validation rules
class CarouselConfiguration {
  /// Whether the carousel should auto-play through items
  final bool autoPlay;
  
  /// Duration between auto-play transitions
  final Duration autoPlayInterval;
  
  /// Duration of the auto-play animation
  final Duration autoPlayAnimationDuration;
  
  /// Whether to enlarge the center page for visual hierarchy
  final bool enlargeCenterPage;
  
  /// Fraction of the viewport that each page should occupy
  final double viewportFraction;
  
  /// Whether infinite scrolling is enabled
  final bool enableInfiniteScroll;
  
  /// Direction of carousel scrolling
  final Axis scrollDirection;
  
  /// Whether to pause auto-play when user touches the carousel
  final bool pauseAutoPlayOnTouch;
  
  /// Callback function when page changes
  final Function(int, dynamic)? onPageChanged;
  
  /// Controller for manual carousel navigation
  final dynamic carouselController;

  const CarouselConfiguration({
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.enlargeCenterPage = true,
    this.viewportFraction = 0.8,
    this.enableInfiniteScroll = true,
    this.scrollDirection = Axis.horizontal,
    this.pauseAutoPlayOnTouch = true,
    this.onPageChanged,
    this.carouselController,
  });

  /// Creates a CarouselConfiguration with validation
  /// Throws ArgumentError if any parameter is invalid
  factory CarouselConfiguration.validated({
    bool autoPlay = true,
    Duration autoPlayInterval = const Duration(seconds: 3),
    Duration autoPlayAnimationDuration = const Duration(milliseconds: 800),
    bool enlargeCenterPage = true,
    double viewportFraction = 0.8,
    bool enableInfiniteScroll = true,
    Axis scrollDirection = Axis.horizontal,
    bool pauseAutoPlayOnTouch = true,
    Function(int, dynamic)? onPageChanged,
    dynamic carouselController,
  }) {
    // Validate autoPlayInterval (1-10 seconds)
    if (autoPlayInterval.inSeconds < 1 || autoPlayInterval.inSeconds > 10) {
      throw ArgumentError(
        'autoPlayInterval must be between 1-10 seconds, got ${autoPlayInterval.inSeconds}s'
      );
    }

    // Validate autoPlayAnimationDuration (200-2000 milliseconds)
    if (autoPlayAnimationDuration.inMilliseconds < 200 || 
        autoPlayAnimationDuration.inMilliseconds > 2000) {
      throw ArgumentError(
        'autoPlayAnimationDuration must be between 200-2000ms, got ${autoPlayAnimationDuration.inMilliseconds}ms'
      );
    }

    // Validate viewportFraction (0.1-1.0)
    if (viewportFraction < 0.1 || viewportFraction > 1.0) {
      throw ArgumentError(
        'viewportFraction must be between 0.1-1.0, got $viewportFraction'
      );
    }

    return CarouselConfiguration(
      autoPlay: autoPlay,
      autoPlayInterval: autoPlayInterval,
      autoPlayAnimationDuration: autoPlayAnimationDuration,
      enlargeCenterPage: enlargeCenterPage,
      viewportFraction: viewportFraction,
      enableInfiniteScroll: enableInfiniteScroll,
      scrollDirection: scrollDirection,
      pauseAutoPlayOnTouch: pauseAutoPlayOnTouch,
      onPageChanged: onPageChanged,
      carouselController: carouselController,
    );
  }

  /// Creates a configuration optimized for streetwear e-commerce UX
  factory CarouselConfiguration.streetwearOptimized({
    Function(int, dynamic)? onPageChanged,
    dynamic carouselController,
  }) {
    return CarouselConfiguration(
      autoPlay: true,                                    // Keep users engaged
      autoPlayInterval: const Duration(seconds: 3),     // Optimal viewing time per product
      autoPlayAnimationDuration: const Duration(milliseconds: 800), // Smooth premium feel
      enlargeCenterPage: true,                           // Focus on featured product
      viewportFraction: 0.8,                           // Show adjacent items for context
      enableInfiniteScroll: true,                       // Seamless browsing experience
      scrollDirection: Axis.horizontal,                 // Standard e-commerce pattern
      pauseAutoPlayOnTouch: true,                      // Respect user interaction
      onPageChanged: onPageChanged,
      carouselController: carouselController,
    );
  }

  /// Creates a copy of this configuration with updated values
  CarouselConfiguration copyWith({
    bool? autoPlay,
    Duration? autoPlayInterval,
    Duration? autoPlayAnimationDuration,
    bool? enlargeCenterPage,
    double? viewportFraction,
    bool? enableInfiniteScroll,
    Axis? scrollDirection,
    bool? pauseAutoPlayOnTouch,
    Function(int, dynamic)? onPageChanged,
    dynamic carouselController,
  }) {
    return CarouselConfiguration(
      autoPlay: autoPlay ?? this.autoPlay,
      autoPlayInterval: autoPlayInterval ?? this.autoPlayInterval,
      autoPlayAnimationDuration: autoPlayAnimationDuration ?? this.autoPlayAnimationDuration,
      enlargeCenterPage: enlargeCenterPage ?? this.enlargeCenterPage,
      viewportFraction: viewportFraction ?? this.viewportFraction,
      enableInfiniteScroll: enableInfiniteScroll ?? this.enableInfiniteScroll,
      scrollDirection: scrollDirection ?? this.scrollDirection,
      pauseAutoPlayOnTouch: pauseAutoPlayOnTouch ?? this.pauseAutoPlayOnTouch,
      onPageChanged: onPageChanged ?? this.onPageChanged,
      carouselController: carouselController ?? this.carouselController,
    );
  }

  /// Validates the current configuration
  /// Returns true if all parameters are within valid ranges
  bool isValid() {
    try {
      // Check autoPlayInterval bounds
      if (autoPlayInterval.inSeconds < 1 || autoPlayInterval.inSeconds > 10) {
        return false;
      }

      // Check autoPlayAnimationDuration bounds
      if (autoPlayAnimationDuration.inMilliseconds < 200 || 
          autoPlayAnimationDuration.inMilliseconds > 2000) {
        return false;
      }

      // Check viewportFraction bounds
      if (viewportFraction < 0.1 || viewportFraction > 1.0) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Returns a list of validation errors, empty if configuration is valid
  List<String> getValidationErrors() {
    final errors = <String>[];

    // Validate autoPlayInterval
    if (autoPlayInterval.inSeconds < 1 || autoPlayInterval.inSeconds > 10) {
      errors.add('autoPlayInterval must be between 1-10 seconds');
    }

    // Validate autoPlayAnimationDuration
    if (autoPlayAnimationDuration.inMilliseconds < 200 || 
        autoPlayAnimationDuration.inMilliseconds > 2000) {
      errors.add('autoPlayAnimationDuration must be between 200-2000ms');
    }

    // Validate viewportFraction
    if (viewportFraction < 0.1 || viewportFraction > 1.0) {
      errors.add('viewportFraction must be between 0.1-1.0');
    }

    return errors;
  }

  @override
  String toString() {
    return 'CarouselConfiguration('
        'autoPlay: $autoPlay, '
        'autoPlayInterval: ${autoPlayInterval.inSeconds}s, '
        'autoPlayAnimationDuration: ${autoPlayAnimationDuration.inMilliseconds}ms, '
        'enlargeCenterPage: $enlargeCenterPage, '
        'viewportFraction: $viewportFraction, '
        'enableInfiniteScroll: $enableInfiniteScroll, '
        'scrollDirection: $scrollDirection, '
        'pauseAutoPlayOnTouch: $pauseAutoPlayOnTouch'
        ')';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is CarouselConfiguration &&
        other.autoPlay == autoPlay &&
        other.autoPlayInterval == autoPlayInterval &&
        other.autoPlayAnimationDuration == autoPlayAnimationDuration &&
        other.enlargeCenterPage == enlargeCenterPage &&
        other.viewportFraction == viewportFraction &&
        other.enableInfiniteScroll == enableInfiniteScroll &&
        other.scrollDirection == scrollDirection &&
        other.pauseAutoPlayOnTouch == pauseAutoPlayOnTouch;
  }

  @override
  int get hashCode {
    return Object.hash(
      autoPlay,
      autoPlayInterval,
      autoPlayAnimationDuration,
      enlargeCenterPage,
      viewportFraction,
      enableInfiniteScroll,
      scrollDirection,
      pauseAutoPlayOnTouch,
    );
  }
}