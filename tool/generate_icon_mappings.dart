import 'dart:io';

/// Tool to auto-generate icon mapping files for Vuesax Flutter Icons
///
/// This script scans all SVG files in the assets folder and generates
/// corresponding Dart classes with static constants for each icon.
void main() async {
  print('🔄 Generating Vuesax icon mappings...');

  final assetsPath = 'assets/Svg';
  final libIconsPath = 'lib/icons';

  // Ensure the lib/icons directory exists
  final iconsDir = Directory(libIconsPath);
  if (!iconsDir.existsSync()) {
    iconsDir.createSync(recursive: true);
  }

  // Generate mappings for All variants
  await generateAllVariants();

  // Generate mappings for Category variants
  await generateCategoryVariants();

  // Generate main export file
  await generateMainExport();

  print('✅ Icon mappings generated successfully!');
}

/// Generate icon mappings for All variants (bold, outline, linear, etc.)
Future<void> generateAllVariants() async {
  final allPath = 'assets/Svg/All';
  final allDir = Directory(allPath);

  if (!allDir.existsSync()) {
    print('❌ Directory $allPath not found');
    return;
  }

  final variants = <String>[];

  await for (final variant in allDir.list()) {
    if (variant is Directory) {
      final variantName = variant.path.split(Platform.pathSeparator).last;
      if (variantName.startsWith('.')) continue; // Skip hidden directories

      print('📁 Processing variant: $variantName');
      variants.add(variantName);

      await generateVariantMapping(variantName, variant.path);
    }
  }

  // Generate combined all icons class
  await generateAllIconsClass(variants);
}

/// Generate icon mapping for a specific variant
Future<void> generateVariantMapping(
    String variantName, String variantPath) async {
  final variantDir = Directory(variantPath);
  final icons = <String>[];

  await for (final file in variantDir.list()) {
    if (file is File && file.path.endsWith('.svg')) {
      final fileName = file.path.split(Platform.pathSeparator).last;
      final iconName = fileName.replaceAll('.svg', '');
      icons.add(iconName);
    }
  }

  icons.sort();

  final className = '${_capitalize(variantName)}Icons';
  final content = _generateVariantClass(className, variantName, icons);

  final outputFile = File('lib/icons/${variantName}_icons.dart');
  await outputFile.writeAsString(content);

  print('✅ Generated ${icons.length} icons for $variantName variant');
}

/// Generate category-based mappings
Future<void> generateCategoryVariants() async {
  final categoryPath = 'assets/Svg/Category';
  final categoryDir = Directory(categoryPath);

  if (!categoryDir.existsSync()) {
    print('❌ Directory $categoryPath not found');
    return;
  }

  final categories = <String>[];

  await for (final category in categoryDir.list()) {
    if (category is Directory) {
      final categoryName = category.path.split(Platform.pathSeparator).last;
      if (categoryName.startsWith('.')) continue;

      print('📁 Processing category: $categoryName');
      categories.add(categoryName);

      await generateCategoryMapping(categoryName, category.path);
    }
  }

  // Generate combined category icons class
  await generateCategoryIconsClass(categories);
}

/// Generate icon mapping for a specific category
Future<void> generateCategoryMapping(
    String categoryName, String categoryPath) async {
  final categoryDir = Directory(categoryPath);
  final icons = <String>[];

  await for (final file in categoryDir.list()) {
    if (file is File && file.path.endsWith('.svg')) {
      final fileName = file.path.split(Platform.pathSeparator).last;
      final iconName = fileName.replaceAll('.svg', '');
      icons.add(iconName);
    }
  }

  icons.sort();

  final className = '${_sanitizeCategoryName(categoryName)}CategoryIcons';
  final content = _generateCategoryClass(className, categoryName, icons);

  final outputFile = File(
      'lib/icons/category_${_sanitizeCategoryName(categoryName).toLowerCase()}_icons.dart');
  await outputFile.writeAsString(content);

  print('✅ Generated ${icons.length} icons for $categoryName category');
}

/// Generate the combined AllIcons class
Future<void> generateAllIconsClass(List<String> variants) async {
  final buffer = StringBuffer();

  buffer.writeln('/// Combined class containing all variant icon collections');
  buffer.writeln('///');
  buffer.writeln('/// Provides access to all Vuesax icon variants including:');
  for (final variant in variants) {
    buffer.writeln('/// - ${_capitalize(variant)} icons');
  }
  buffer.writeln('class AllIcons {');

  // Import statements will be added at the top
  final imports = <String>[];

  for (final variant in variants) {
    final className = '${_capitalize(variant)}Icons';
    imports.add("import '${variant}_icons.dart';");
    buffer.writeln('  /// ${_capitalize(variant)} variant icons');
    buffer.writeln('  static const $className $variant = $className();');
    buffer.writeln();
  }

  buffer.writeln('}');

  // Combine imports and class
  final fullContent = StringBuffer();
  for (final import in imports) {
    fullContent.writeln(import);
  }
  fullContent.writeln();
  fullContent.write(buffer.toString());

  final outputFile = File('lib/icons/all_icons.dart');
  await outputFile.writeAsString(fullContent.toString());

  print('✅ Generated AllIcons class with ${variants.length} variants');
}

/// Generate the combined CategoryIcons class
Future<void> generateCategoryIconsClass(List<String> categories) async {
  final buffer = StringBuffer();

  buffer.writeln('/// Combined class containing all category icon collections');
  buffer.writeln('///');
  buffer
      .writeln('/// Provides access to all Vuesax icon categories including:');
  for (final category in categories) {
    buffer.writeln('/// - ${category.replaceAll('-', ' ')} icons');
  }
  buffer.writeln('class CategoryIcons {');

  // Import statements will be added at the top
  final imports = <String>[];

  for (final category in categories) {
    final sanitizedName = _sanitizeCategoryName(category);
    final className = '${sanitizedName}CategoryIcons';
    imports.add("import 'category_${sanitizedName.toLowerCase()}_icons.dart';");

    final propertyName = _camelCase(sanitizedName);
    buffer.writeln('  /// ${category.replaceAll('-', ' ')} category icons');
    buffer.writeln('  static const $className $propertyName = $className();');
    buffer.writeln();
  }

  buffer.writeln('}');

  // Combine imports and class
  final fullContent = StringBuffer();
  for (final import in imports) {
    fullContent.writeln(import);
  }
  fullContent.writeln();
  fullContent.write(buffer.toString());

  final outputFile = File('lib/icons/category_icons.dart');
  await outputFile.writeAsString(fullContent.toString());

  print('✅ Generated CategoryIcons class with ${categories.length} categories');
}

/// Generate main export file
Future<void> generateMainExport() async {
  final content = '''// Vuesax Flutter Icons - Main Export File
//
// This file exports all icon classes and the CustomSvgIcon widget
// for easy access throughout your Flutter application.

// Main widget
export 'widgets/custom_svg_icon.dart';

// All variant icons
export 'icons/all_icons.dart';

// Category icons
export 'icons/category_icons.dart';

// Individual variant classes (for direct access if needed)
export 'icons/bold_icons.dart';
export 'icons/outline_icons.dart';
export 'icons/linear_icons.dart';
export 'icons/bulk_icons.dart';
export 'icons/twotone_icons.dart';
export 'icons/broken_icons.dart';
''';

  final outputFile = File('lib/vuesax_flutter_icons.dart');
  await outputFile.writeAsString(content);

  print('✅ Generated main export file');
}

/// Generate class content for a variant
String _generateVariantClass(
    String className, String variantName, List<String> icons) {
  final buffer = StringBuffer();

  buffer.writeln(
      '/// $className - ${_capitalize(variantName)} variant Vuesax icons');
  buffer.writeln('///');
  buffer.writeln('/// Contains ${icons.length} ${variantName} style icons.');
  buffer.writeln('/// Usage: ${className}.iconName');
  buffer.writeln('class $className {');
  buffer.writeln('  const ${className}();');
  buffer.writeln();

  for (final icon in icons) {
    final constantName = _sanitizeIconName(icon);
    final assetPath = 'assets/Svg/All/$variantName/$icon.svg';
    final comment = _generateIconComment(icon);

    buffer.writeln('  $comment');
    buffer.writeln("  static const String $constantName = '$assetPath';");
    buffer.writeln();
  }

  buffer.writeln('}');

  return buffer.toString();
}

/// Generate class content for a category
String _generateCategoryClass(
    String className, String categoryName, List<String> icons) {
  final buffer = StringBuffer();

  buffer.writeln(
      '/// $className - ${categoryName.replaceAll('-', ' ')} category Vuesax icons');
  buffer.writeln('///');
  buffer.writeln(
      '/// Contains ${icons.length} icons related to ${categoryName.replaceAll('-', ' ').toLowerCase()}.');
  buffer.writeln('/// Usage: ${className}.iconName');
  buffer.writeln('class $className {');
  buffer.writeln('  const ${className}();');
  buffer.writeln();

  for (final icon in icons) {
    final constantName = _sanitizeIconName(icon);
    final assetPath = 'assets/Svg/Category/$categoryName/$icon.svg';
    final comment = _generateIconComment(icon);

    buffer.writeln('  $comment');
    buffer.writeln("  static const String $constantName = '$assetPath';");
    buffer.writeln();
  }

  buffer.writeln('}');

  return buffer.toString();
}

/// Generate comment for an icon
String _generateIconComment(String iconName) {
  final displayName = iconName.replaceAll('-', ' ').replaceAll('_', ' ');
  return '/// ${_capitalize(displayName)} icon';
}

/// Sanitize icon name to be a valid Dart identifier
String _sanitizeIconName(String name) {
  // Handle names that start with numbers
  String sanitized = name;
  if (RegExp(r'^\d').hasMatch(sanitized)) {
    sanitized = 'icon$sanitized';
  }

  // Replace hyphens and other invalid characters with underscores
  sanitized = sanitized.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');

  // Ensure camelCase
  final parts = sanitized.split('_');
  if (parts.length > 1) {
    sanitized = parts.first.toLowerCase() +
        parts.skip(1).map((part) => _capitalize(part)).join('');
  } else {
    sanitized = sanitized.toLowerCase();
  }

  return sanitized;
}

/// Sanitize category name to be a valid Dart class name part
String _sanitizeCategoryName(String name) {
  return name
      .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
      .split('_')
      .map((part) => _capitalize(part))
      .join('');
}

/// Convert to camelCase
String _camelCase(String text) {
  if (text.isEmpty) return text;
  return text[0].toLowerCase() + text.substring(1);
}

/// Capitalize first letter
String _capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}
