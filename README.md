# Vuesax Flutter Icons

A **revolutionary zero-bundle** Flutter package providing beautiful SVG icons from the Vuesax design system. Features **CDN-based loading** with **ZERO bundle size impact** - your app stays lightning fast and ultra-lightweight!

[![pub package](https://img.shields.io/pub/v/vuesax_flutter_icons.svg)](https://pub.dev/packages/vuesax_flutter_icons)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🚨 **ZERO BUNDLE SIZE - REVOLUTIONARY ARCHITECTURE**

### 📦 **Bundle Size Comparison**

| Package Type | Bundle Size | Assets | Loading |
|-------------|-------------|--------|---------|
| **Traditional Icon Package** | +13.9MB | All bundled | Instant |
| **🚀 Vuesax Flutter Icons** | **+50KB** | **Zero bundled** | ~100ms |
| **📊 Savings** | **99.6%** | **13.9MB saved** | Acceptable |

### ⚡ **How We Achieved Zero Bundle Size**

- 🎯 **Smart Architecture**: Assets stored in separate branch, code in main branch
- 🌐 **CDN-First Loading**: Icons load from global CDN (jsDelivr)
- 📦 **No Assets Bundled**: Your APK/IPA stays ultra-lightweight
- 🚀 **On-Demand**: Load only icons you actually use

## ✨ Features

- 🌐 **CDN-hosted icons** with automatic caching
- 📦 **TRUE ZERO bundle impact** - only ~50KB package size vs 13.9MB of assets
- 🎨 **6 icon variants**: Bold, Outline, Linear, Bulk, Twotone, Broken  
- 🎯 **Type-safe API** with IDE autocomplete (NEW!)
- ⚙️ **Full customization**: size, color, width, height, fit, alignment
- 🔄 **Backward compatibility** with legacy APIs
- 🚀 **On-demand loading** - icons fetched only when needed
- 📱 **Flutter compatibility**: Works with Flutter 2.17.0+

## 🚀 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  vuesax_flutter_icons:
    git:
      url: https://github.com/Brain-codes/vuesax-flutter-icons.git
      ref: main  # Important: Use main branch for zero bundle size
```

Run `flutter pub get` to install.

**Result: Only ~50KB added to your app bundle! 🎉**

## 📖 Usage

### **🎯 NEW: Type-Safe API (Recommended)**

```dart
import 'package:vuesax_flutter_icons/vuesax_flutter_icons.dart';

// Simple usage - loads from CDN automatically
VuesaxIcon(
  variant: 'linear',
  iconName: 'home',
  size: 32,
  color: Colors.blue,
)

// Type-safe constants with autocomplete
VuesaxIcon(
  iconId: VuesaxIcons.boldActivity,
  size: 24,
  color: Colors.green,
)

// Factory constructors
VuesaxIcon.variant('outline', 'user')
```

### **Centralized Configuration**

Edit all settings in one place:

```dart
// lib/config/vuesax_config.dart
class VuesaxConfig {
  static const String githubUsername = 'Brain-codes';           // Your repo
  static const String repositoryName = 'vuesax-flutter-icons';  // Your repo name
  static const String defaultVariant = 'linear';               // Default style
  static const double defaultSize = 24.0;                      // Default size
  static const bool enableDebugLogging = false;                // Debug mode
  // ... customize everything in one file
}
```

## 🎨 Icon Variants

| Variant     | Example                                            | Description              |
| ----------- | -------------------------------------------------- | ------------------------ |
| **Bold**    | `VuesaxIcon(variant: 'bold', iconName: 'home')`    | Filled, bold appearance  |
| **Outline** | `VuesaxIcon(variant: 'outline', iconName: 'home')` | Clean outline style      |
| **Linear**  | `VuesaxIcon(variant: 'linear', iconName: 'home')`  | Minimalist linear design |
| **Bulk**    | `VuesaxIcon(variant: 'bulk', iconName: 'home')`    | Partially filled style   |
| **Twotone** | `VuesaxIcon(variant: 'twotone', iconName: 'home')` | Two-tone color design    |
| **Broken**  | `VuesaxIcon(variant: 'broken', iconName: 'home')`  | Broken line style        |

## ⚙️ Customization Options

```dart
VuesaxIcon(
  variant: 'bold',
  iconName: 'settings',

  // Size options
  size: 32,                    // Sets both width and height
  width: 40,                   // Custom width override
  height: 30,                  // Custom height override

  // Styling
  color: Colors.purple,        // Icon color tint
  fit: BoxFit.contain,         // How to fit the icon
  alignment: Alignment.center, // Icon alignment

  // Accessibility
  semanticsLabel: "Settings icon",
)
```

## 🌐 CDN Architecture

Your icons are loaded from a blazing-fast global CDN:

```
https://cdn.jsdelivr.net/gh/Brain-codes/vuesax-flutter-icons@main/assets/Svg/All/{variant}/{icon}.svg
```

### **Loading Behavior**

1. **First use**: Loads from CDN (~100-300ms)
2. **Subsequent uses**: Instant from memory cache
3. **Network issues**: Shows clean placeholder (no crashes)

### **Bundle Size Comparison**

| Approach                    | Your App Size | Loading Speed     | Offline Support     |
| --------------------------- | ------------- | ----------------- | ------------------- |
| **Bundled Assets**          | +13.9MB 😱    | Instant           | ✅ Full             |
| **CDN-Only (This Package)** | +50KB 🎉      | ~200ms first load | ⚠️ Placeholder only |
| **Hybrid**                  | +1-2MB        | ~100ms            | ✅ Essential icons  |

## 📱 Example App

Run the interactive example to see CDN loading in action:

```bash
cd example
flutter run
```

Features:

- ✅ Live CDN URL display
- ✅ Toggle between CDN and local modes
- ✅ Real-time icon customization
- ✅ Debug logging to track network requests
- ✅ Performance comparison demos

## 🔧 Setup Your CDN

### 1. **Upload SVG Assets to GitHub**

Create a public repository with your SVG collection:

```bash
git clone https://github.com/Brain-codes/vuesax-flutter-icons
# Add your assets/Svg/All/ folder structure
git add . && git commit -m "Add icon collection" && git push
```

### 2. **Update Configuration**

Edit `VuesaxConfig` with your repository details:

```dart
static const String githubUsername = 'Brain-codes';
static const String repositoryName = 'vuesax-flutter-icons';
```

### 3. **Test CDN URLs**

Verify setup by opening in browser:

```
https://cdn.jsdelivr.net/gh/Brain-codes/vuesax-flutter-icons@main/assets/Svg/All/linear/home.svg
```

## 🎯 Type-Safe Constants

Get full IDE autocomplete support:

```dart
// All variants available as constants
VuesaxIcons.boldActivity      // "bold/activity"
VuesaxIcons.outlineHome       // "outline/home"
VuesaxIcons.linearUser        // "linear/user"
VuesaxIcons.bulkHeart         // "bulk/heart"
VuesaxIcons.twotoneMessage    // "twotone/message"
VuesaxIcons.brokenCalendar    // "broken/calendar"
```

## 🔍 Debug Mode

Enable debug logging to track CDN behavior:

```dart
// In VuesaxConfig
static const bool enableDebugLogging = true;
```

Console output:

```
VuesaxIcon: Loading from CDN: https://cdn.jsdelivr.net/gh/.../linear/home.svg
VuesaxIcon: Loading from cache: linear/home
VuesaxIcon: CDN failed, showing placeholder
```

## 📚 Popular Icons Reference

| Icon     | Bold                       | Linear                       | Outline                       |
| -------- | -------------------------- | ---------------------------- | ----------------------------- |
| Home     | `VuesaxIcons.boldHome`     | `VuesaxIcons.linearHome`     | `VuesaxIcons.outlineHome`     |
| User     | `VuesaxIcons.boldUser`     | `VuesaxIcons.linearUser`     | `VuesaxIcons.outlineUser`     |
| Heart    | `VuesaxIcons.boldHeart`    | `VuesaxIcons.linearHeart`    | `VuesaxIcons.outlineHeart`    |
| Activity | `VuesaxIcons.boldActivity` | `VuesaxIcons.linearActivity` | `VuesaxIcons.outlineActivity` |
| Settings | `VuesaxIcons.boldSetting`  | `VuesaxIcons.linearSetting`  | `VuesaxIcons.outlineSetting`  |

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Credits

- Icons from the [Vuesax](https://vuesax.com/) design system
- CDN powered by [jsDelivr](https://www.jsdelivr.com/)
- Built with ❤️ for the Flutter community

---

## 📊 **Bundle Size Impact**

**Before (Traditional Approach)**:

```
Your app: 15MB base + 13.9MB icons = 28.9MB total 😱
```

**After (CDN Approach)**:

```
Your app: 15MB base + 50KB package = 15.05MB total 🎉
```

**Savings: 13.85MB (48% smaller app!)** 📦✨
