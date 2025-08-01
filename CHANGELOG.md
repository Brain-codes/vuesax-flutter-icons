# Changelog

All notable changes to the Vuesax Flutter Icons package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-01-XX

### Added

- Initial release of Vuesax Flutter Icons package
- **VuesaxIcon widget** with network-based CDN loading
- **6 icon variants**: Bold, Outline, Linear, Bulk, Twotone, Broken
- **Type-safe constants** in `VuesaxIcons` class for IDE autocomplete
- **CDN integration** with `https://cdn.vuesax.dev/flutter/{iconId}.svg`
- **In-memory caching** for improved performance
- **Local asset fallbacks** for offline usage
- **Factory constructors**: `VuesaxIcon.variant()` and `VuesaxIcon.asset()`
- **Full customization** support: size, color, width, height, fit, alignment
- **Backward compatibility** with legacy `CustomSvgIcon` widget
- **Auto-generation tool** for icon mappings (`tool/generate_icon_mappings.dart`)
- **Interactive example app** with real-time customization
- **Flutter 2.17.0+ compatibility**

### Legacy Support

- **CustomSvgIcon widget** (deprecated but functional)
- **Icon mapping classes**: BoldIcons, OutlineIcons, LinearIcons, BulkIcons, TwotoneIcons, BrokenIcons

### Dependencies

- `flutter_svg: ^1.1.6` - SVG rendering with broad compatibility
- `http: ^0.13.5` - Network requests for CDN loading
- `flutter: >=2.17.0` - Minimum Flutter SDK version

### Documentation

- Comprehensive README with usage examples
- Type-safe constant documentation
- CDN architecture explanation
- Migration guide from legacy APIs

### Testing

- Example app with interactive demonstrations
- Support for both CDN and local asset modes
- Error handling and fallback mechanisms
- ✨ Initial release of Vuesax Flutter Icons package
- 🎨 1000+ high-quality SVG icons from the Vuesax icon library
- 🎯 Support for 6 icon variants: Bold, Outline, Linear, Bulk, Twotone, Broken
- 📱 Full Flutter compatibility from 2.17.0 to latest versions
- 🎮 Comprehensive customization options:
  - Size control (width, height, or unified size)
  - Color customization with blend modes
  - Fit and alignment options
  - Semantic labels for accessibility
  - RTL layout support
- 📂 Category-based icon organization (32 categories)
- 🔧 Auto-generated icon mappings from SVG assets
- 📖 Comprehensive documentation and examples
- 🧪 Example app demonstrating all features
- ⚡ Optimized SVG rendering with flutter_svg

### Features in Detail

#### Icon Variants

- **BoldIcons**: 896 filled/solid style icons
- **OutlineIcons**: 896 outlined/stroke style icons
- **LinearIcons**: 919 linear/minimal style icons
- **BulkIcons**: 895 bulk/mixed style icons
- **TwotoneIcons**: 894 two-tone style icons
- **BrokenIcons**: 896 broken/dashed style icons

#### Icon Categories

- Archive, Arrow, Astrology, Building, Business
- Call, Car, Content-Edit, Design-Tools, Delivery
- Emails-Messages, Files, Grid, Location, Money
- Notifications, Programming, Security, Settings
- Shop, Support, Time, Users, Video-Audio-Image
- Weather, and more...

#### CustomSvgIcon Widget

- Full property support for SVG customization
- Backward compatibility with older Flutter versions
- Forward compatibility with newer Flutter features
- Performance optimizations for smooth rendering

#### Developer Experience

- Auto-generation tool for icon mappings
- Clear naming conventions and organization
- Extensive documentation and examples
- Easy integration with existing Flutter projects

### Technical Details

- **Minimum Flutter**: 2.17.0
- **Minimum Dart**: 2.17.0
- **Dependencies**: flutter_svg ^1.1.6
- **Asset Size**: ~5MB (SVG icons)
- **Performance**: Optimized for fast rendering
- **Tree Shaking**: Supports dead code elimination

### Documentation

- Complete README with usage examples
- Inline code documentation
- Example app with interactive demo
- Migration guide for different Flutter versions
