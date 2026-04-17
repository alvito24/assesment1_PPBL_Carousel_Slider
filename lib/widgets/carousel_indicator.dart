import 'package:flutter/material.dart';

/// CarouselIndicator is a custom widget that displays dot indicators for carousel position
/// and provides tap functionality for direct page navigation.
/// 
/// Features:
/// - Visual feedback showing current carousel position
/// - Tap functionality for direct navigation to any page
/// - Streetwear theme styling (white/grey dots)
/// - Smooth animations between state changes
/// - Responsive sizing and spacing
class CarouselIndicator extends StatelessWidget {
  /// Current active page index
  final int currentIndex;
  
  /// Total number of items in the carousel
  final int itemCount;
  
  /// Callback function when an indicator dot is tapped
  final Function(int) onTap;
  
  /// Size of each indicator dot
  final double dotSize;
  
  /// Spacing between indicator dots
  final double spacing;
  
  /// Color of the active indicator dot
  final Color activeColor;
  
  /// Color of inactive indicator dots
  final Color inactiveColor;
  
  /// Animation duration for state changes
  final Duration animationDuration;

  const CarouselIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
    required this.onTap,
    this.dotSize = 10.0,
    this.spacing = 8.0,
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0xFF666666),
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => _buildIndicatorDot(index),
      ),
    );
  }

  /// Builds individual indicator dot with animation and tap functionality
  Widget _buildIndicatorDot(int index) {
    final bool isActive = index == currentIndex;
    
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: animationDuration,
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: spacing / 2),
        width: isActive ? dotSize * 1.2 : dotSize,
        height: isActive ? dotSize * 1.2 : dotSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? activeColor : inactiveColor,
          boxShadow: isActive ? [
            BoxShadow(
              color: activeColor.withValues(alpha: 0.3),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ] : null,
        ),
      ),
    );
  }
}