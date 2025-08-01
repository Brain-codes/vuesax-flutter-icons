import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import '../config/vuesax_config.dart';

/// A high-performance SVG icon widget for Vuesax icons
///
/// Supports both local assets and CDN-hosted icons with intelligent loading.
/// Automatically handles loading states, error fallbacks, and offline support.
/// Compatible with Flutter 2.17.0+ for both older and newer Flutter versions.
class VuesaxIcon extends StatefulWidget {
  /// Icon identifier in format 'variant/iconName' (e.g., 'linear/home')
  /// When provided, loads from CDN using VuesaxConfig settings
  final String? iconId;

  /// Direct path to local SVG asset (fallback for offline or custom icons)
  final String? assetPath;

  /// Icon variant (bold, outline, linear, bulk, twotone, broken)
  /// If provided with iconName, will be combined to create iconId
  final String? variant;

  /// Icon name (e.g., 'home', 'user', 'activity')
  /// Used with variant to create iconId
  final String? iconName;

  /// Default size (used for both width and height if those aren't set)
  final double? size;

  /// Optional width override
  final double? width;

  /// Optional height override
  final double? height;

  /// Icon tint color
  final Color? color;

  /// How the SVG fits inside the container
  final BoxFit fit;

  /// Alignment within the container
  final Alignment alignment;

  /// Accessibility label
  final String? semanticsLabel;

  /// Support for RTL layouts
  final bool matchTextDirection;

  /// Allow drawing outside the widget bounds
  final bool allowDrawingOutsideViewBox;

  /// Color blend mode
  final BlendMode colorBlendMode;

  /// Fallback icon to show on error
  final Widget? errorWidget;

  /// Loading placeholder widget
  final Widget? loadingWidget;

  /// Use local assets instead of CDN (overrides VuesaxConfig.preferCDN)
  final bool? useLocalAssets;

  const VuesaxIcon({
    Key? key,
    this.iconId,
    this.assetPath,
    this.variant,
    this.iconName,
    this.size,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
    this.matchTextDirection = false,
    this.allowDrawingOutsideViewBox = false,
    this.colorBlendMode = BlendMode.srcIn,
    this.errorWidget,
    this.loadingWidget,
    this.useLocalAssets,
  })  : assert(
          iconId != null || assetPath != null || (variant != null && iconName != null),
          'Either iconId, assetPath, or both variant and iconName must be provided',
        ),
        super(key: key);

  /// Create a VuesaxIcon from a specific variant and icon name
  ///
  /// Example: VuesaxIcon.variant('linear', 'home')
  factory VuesaxIcon.variant(
    String variant,
    String iconName, {
    double? size,
    Color? color,
    bool? useLocalAssets,
  }) {
    return VuesaxIcon(
      variant: variant,
      iconName: iconName,
      size: size,
      color: color,
      useLocalAssets: useLocalAssets,
    );
  }

  /// Create a VuesaxIcon from a local asset path
  ///
  /// Example: VuesaxIcon.asset('assets/icons/custom.svg')
  factory VuesaxIcon.asset(
    String assetPath, {
    double? size,
    Color? color,
  }) {
    return VuesaxIcon(
      assetPath: assetPath,
      size: size,
      color: color,
    );
  }

  @override
  State<VuesaxIcon> createState() => _VuesaxIconState();
}

class _VuesaxIconState extends State<VuesaxIcon> {
  // Simple in-memory cache for loaded SVG strings
  static final Map<String, String> _svgCache = {};

  String? get _resolvedIconId {
    if (widget.iconId != null) return widget.iconId;
    if (widget.variant != null && widget.iconName != null) {
      return VuesaxConfig.getIconId(widget.variant!, widget.iconName!);
    }
    return null;
  }

  bool get _shouldUseLocalAssets {
    return widget.useLocalAssets ?? !VuesaxConfig.preferCDN;
  }

  @override
  Widget build(BuildContext context) {
    // Use size as default for width/height if not specified
    final double? finalWidth = widget.width ?? widget.size ?? VuesaxConfig.defaultSize;
    final double? finalHeight = widget.height ?? widget.size ?? VuesaxConfig.defaultSize;
    final Color? finalColor = widget.color ?? VuesaxConfig.defaultColor;

    // If assetPath is provided, use local asset
    if (widget.assetPath != null) {
      return _buildLocalSvg(finalWidth, finalHeight, finalColor);
    }

    // If useLocalAssets is true, try to load from local assets first
    if (_shouldUseLocalAssets && _resolvedIconId != null) {
      return _buildLocalSvgFromIconId(finalWidth, finalHeight, finalColor);
    }

    // Otherwise, load from CDN
    return _buildNetworkSvg(finalWidth, finalHeight, finalColor);
  }

  Widget _buildLocalSvg(double? width, double? height, Color? color) {
    if (VuesaxConfig.enableDebugLogging) {
      debugPrint('VuesaxIcon: Loading local asset: ${widget.assetPath}');
    }

    return SvgPicture.asset(
      widget.assetPath!,
      package: 'vuesax_flutter_icons',
      width: width,
      height: height,
      color: color,
      fit: widget.fit,
      alignment: widget.alignment,
      semanticsLabel: widget.semanticsLabel,
      matchTextDirection: widget.matchTextDirection,
      allowDrawingOutsideViewBox: widget.allowDrawingOutsideViewBox,
      colorBlendMode: widget.colorBlendMode,
    );
  }

  Widget _buildLocalSvgFromIconId(double? width, double? height, Color? color) {
    // Convert iconId to local asset path using config
    final localAssetPath = '${VuesaxConfig.localAssetPath}/${_resolvedIconId}.svg';

    if (VuesaxConfig.enableDebugLogging) {
      debugPrint('VuesaxIcon: Loading local asset from iconId: $localAssetPath');
    }

    try {
      return SvgPicture.asset(
        localAssetPath,
        package: 'vuesax_flutter_icons',
        width: width,
        height: height,
        color: color,
        fit: widget.fit,
        alignment: widget.alignment,
        semanticsLabel: widget.semanticsLabel,
        matchTextDirection: widget.matchTextDirection,
        allowDrawingOutsideViewBox: widget.allowDrawingOutsideViewBox,
        colorBlendMode: widget.colorBlendMode,
      );
    } catch (e) {
      if (VuesaxConfig.enableDebugLogging) {
        debugPrint('VuesaxIcon: Local asset failed, falling back to error widget: $e');
      }
      return _buildErrorWidget(width, height);
    }
  }

  Widget _buildNetworkSvg(double? width, double? height, Color? color) {
    if (_resolvedIconId == null) {
      return _buildErrorWidget(width, height);
    }

    // Extract variant and icon name from iconId
    final parts = _resolvedIconId!.split('/');
    if (parts.length != 2) {
      if (VuesaxConfig.enableDebugLogging) {
        debugPrint('VuesaxIcon: Invalid iconId format: $_resolvedIconId');
      }
      return _buildErrorWidget(width, height);
    }

    final variant = parts[0];
    final iconName = parts[1];

    // Validate variant
    if (!VuesaxConfig.isValidVariant(variant)) {
      if (VuesaxConfig.enableDebugLogging) {
        debugPrint('VuesaxIcon: Invalid variant: $variant');
      }
      return _buildErrorWidget(width, height);
    }

    final fullUrl = VuesaxConfig.buildCDNUrl(variant, iconName);

    if (VuesaxConfig.enableDebugLogging) {
      debugPrint('VuesaxIcon: Loading from CDN: $fullUrl');
    }

    // Check cache first
    if (VuesaxConfig.enableInMemoryCache && _svgCache.containsKey(fullUrl)) {
      if (VuesaxConfig.enableDebugLogging) {
        debugPrint('VuesaxIcon: Loading from cache: $fullUrl');
      }
      return SvgPicture.string(
        _svgCache[fullUrl]!,
        width: width,
        height: height,
        color: color,
        fit: widget.fit,
        alignment: widget.alignment,
        semanticsLabel: widget.semanticsLabel,
        matchTextDirection: widget.matchTextDirection,
        allowDrawingOutsideViewBox: widget.allowDrawingOutsideViewBox,
        colorBlendMode: widget.colorBlendMode,
      );
    }

    return FutureBuilder<String>(
      future: _loadSvgFromNetwork(fullUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingWidget(width, height);
        }

        if (snapshot.hasError || !snapshot.hasData) {
          if (VuesaxConfig.enableDebugLogging) {
            debugPrint('VuesaxIcon: CDN failed, trying fallback: ${snapshot.error}');
          }
          
          // Try to fallback to local asset if network fails and fallback is enabled
          if (VuesaxConfig.enableLocalFallback && _resolvedIconId != null) {
            return _buildLocalSvgFromIconId(width, height, color);
          }
          
          // For CDN-only packages, show a user-friendly error or fallback icon
          return _buildErrorWidget(width, height);
        }

        // Cache the loaded SVG
        if (VuesaxConfig.enableInMemoryCache) {
          _svgCache[fullUrl] = snapshot.data!;
        }

        return SvgPicture.string(
          snapshot.data!,
          width: width,
          height: height,
          color: color,
          fit: widget.fit,
          alignment: widget.alignment,
          semanticsLabel: widget.semanticsLabel,
          matchTextDirection: widget.matchTextDirection,
          allowDrawingOutsideViewBox: widget.allowDrawingOutsideViewBox,
          colorBlendMode: widget.colorBlendMode,
        );
      },
    );
  }

  Future<String> _loadSvgFromNetwork(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load icon: HTTP ${response.statusCode}');
      }
    } catch (e) {
      if (VuesaxConfig.enableDebugLogging) {
        debugPrint('VuesaxIcon: Network error: $e');
      }
      rethrow;
    }
  }

  Widget _buildLoadingWidget(double? width, double? height) {
    if (widget.loadingWidget != null) {
      return widget.loadingWidget!;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: SizedBox(
          width: (width ?? 24) * 0.5,
          height: (height ?? 24) * 0.5,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(double? width, double? height) {
    if (widget.errorWidget != null) {
      return widget.errorWidget!;
    }

    // For CDN-only packages, show a simple fallback
    // Note: Fallback icon loading is disabled to avoid infinite loops in pure CDN mode
    if (VuesaxConfig.enableLocalFallback && 
        VuesaxConfig.fallbackIconName.isNotEmpty && 
        _resolvedIconId != VuesaxConfig.fallbackIconName) {
      final fallbackVariant = widget.variant ?? VuesaxConfig.defaultVariant;
      return VuesaxIcon(
        variant: fallbackVariant,
        iconName: VuesaxConfig.fallbackIconName,
        size: widget.size,
        width: width,
        height: height,
        color: widget.color,
        fit: widget.fit,
        alignment: widget.alignment,
        useLocalAssets: true, // Use local for fallback to avoid infinite loop
      );
    }

    // Pure CDN mode: show a clean placeholder
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Icon(
        Icons.image_outlined,
        size: (width ?? 24) * 0.6,
        color: Colors.grey.shade400,
      ),
    );
  }
}

/// Legacy alias for backward compatibility
///
/// @deprecated Use VuesaxIcon instead
@Deprecated('Use VuesaxIcon instead')
class CustomSvgIcon extends VuesaxIcon {
  const CustomSvgIcon({
    Key? key,
    required String assetPath,
    double? size,
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    String? semanticsLabel,
    bool matchTextDirection = false,
    bool allowDrawingOutsideViewBox = false,
    BlendMode colorBlendMode = BlendMode.srcIn,
  }) : super(
          key: key,
          assetPath: assetPath,
          size: size,
          width: width,
          height: height,
          color: color,
          fit: fit,
          alignment: alignment,
          semanticsLabel: semanticsLabel,
          matchTextDirection: matchTextDirection,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
          colorBlendMode: colorBlendMode,
        );
}
