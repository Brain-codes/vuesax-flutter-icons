/// Configuration file for Vuesax Flutter Icons package
/// Edit all CDN settings, defaults, and behavior here
import 'package:flutter/material.dart';

class VuesaxConfig {
  // ========================
  // CDN Configuration
  // ========================
  
  /// GitHub repository information
  static const String githubUsername = 'YOUR_GITHUB_USERNAME';  // ← Change this to your username
  static const String repositoryName = 'vuesax-flutter-icons';
  static const String branch = 'main';
  
  /// Base CDN URL for icons (using jsDelivr for better performance)
  static const String baseCDN = 'https://cdn.jsdelivr.net/gh/$githubUsername/$repositoryName@$branch';
  
  /// Alternative: Use raw GitHub CDN (comment out above and uncomment below)
  // static const String baseCDN = 'https://raw.githubusercontent.com/$githubUsername/$repositoryName/$branch';
  
  /// Asset path structure within the repository
  static const String assetPath = 'assets/Svg/All';
  
  /// Full CDN URL template: {baseCDN}/{assetPath}/{variant}/{iconName}.svg
  static String buildCDNUrl(String variant, String iconName) {
    return '$baseCDN/$assetPath/$variant/$iconName.svg';
  }
  
  // ========================
  // Default Settings
  // ========================
  
  /// Default icon variant: bold, outline, linear, bulk, twotone, broken
  static const String defaultVariant = 'linear';
  
  /// Default icon size
  static const double defaultSize = 24.0;
  
  /// Default color (null means inherit from theme)
  static const Color? defaultColor = null;
  
  // ========================
  // Fallback & Error Handling
  // ========================
  
  /// Whether to use local assets as fallback when CDN fails
  /// Set to false for pure CDN-only package (no bundle size impact)
  static const bool enableLocalFallback = false;
  
  /// Fallback icon name (used when requested icon fails to load)
  static const String fallbackIconName = 'home';
  
  /// Whether to cache icons in memory for better performance
  static const bool enableInMemoryCache = true;
  
  /// Cache duration for network icons (in minutes)
  static const int cacheDurationMinutes = 60;
  
  // ========================
  // Development & Debug
  // ========================
  
  /// Enable debug logging for CDN requests and fallbacks
  static const bool enableDebugLogging = false;
  
  /// Whether to prefer CDN over local assets (set false for offline-first)
  /// For pure CDN package, this should always be true
  static const bool preferCDN = true;
  
  // ========================
  // Asset Configuration
  // ========================
  
  /// Local asset path template for fallbacks
  static const String localAssetPath = 'packages/vuesax_flutter_icons/assets/Svg/All';
  
  /// Available icon variants
  static const List<String> availableVariants = [
    'bold',
    'outline', 
    'linear',
    'bulk',
    'twotone',
    'broken',
  ];
  
  // ========================
  // Validation
  // ========================
  
  /// Validate if variant is supported
  static bool isValidVariant(String variant) {
    return availableVariants.contains(variant.toLowerCase());
  }
  
  /// Get formatted icon ID for CDN or local usage
  static String getIconId(String variant, String iconName) {
    return '$variant/$iconName';
  }
}
