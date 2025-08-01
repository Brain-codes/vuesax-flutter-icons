# GitHub Copilot Instruction for `vuesax-flutter-icons`

## 🧠 Project Goal

Create a Flutter icon package named **`vuesax-flutter-icons`** that:

- Provides **SVG-based icon sets** (e.g., Vuesax icons) in variants like `solid`, `outline`, etc.
- Supports **full customization** (`size`, `width`, `height`, `color`, etc.)
- Works with **older and newer Flutter versions**
- Is **small in size**, but **scalable and maintainable**
- Is **ready for publication** on `pub.dev`

---

## ✅ Copilot Guidance

> Use GitHub Copilot with the following key principles and suggestions in mind:

### 1. 🏗️ Create Package
- Scaffold package in folder:
  ```bash
  mkdir vuesax-flutter-icons && cd vuesax-flutter-icons
  flutter create --template=package ./
  ```

### 2. 🗂️ Organize SVGs in assets/
- Use this structure:
  ```
  assets/
  ├── outline/
  │   ├── home.svg
  │   ├── user.svg
  └── solid/
      ├── home.svg
      ├── user.svg
  ```

### 3. 📦 Update pubspec.yaml
- Ensure all asset folders are declared:
  ```yaml
  flutter:
    assets:
      - assets/outline/
      - assets/solid/
  ```

### 4. 🧱 Write Dart Icon Mapping Files
- Create `lib/icons/outline_icons.dart` and `solid_icons.dart`
- Map string keys to asset paths:
  ```dart
  final Map<String, String> outlineIcons = {
    "home": "assets/outline/home.svg",
    "user": "assets/outline/user.svg",
  };
  ```

### 5. 🖼️ Create Custom Rendering Widget
- `CustomSvgIcon` widget should accept:
  ```dart
  CustomSvgIcon(
    name: "home",
    variant: "outline",
    size: 24,
    width: 24,
    height: 24,
    color: Colors.blue,
  )
  ```
- Use `flutter_svg` for SVG rendering

### 6. ⚙️ Create Dart Script to Auto-generate Mappings
- Write a script in `tool/` folder:
  - Auto-scan assets
  - Create/overwrite icon map files

### 7. 💡 Use GitHub Copilot Effectively
- Let Copilot help:
  - Write mapping boilerplate
  - Widget customization
  - Pubspec edits
  - Error fixing
- Reference this file while prompting

### 8. 🧪 Setup Example App
- In `/example` folder:
  - Show all variants
  - Let user switch color, size, etc.

### 9. 📤 Prepare for pub.dev
- Add:
  - `README.md`
  - `CHANGELOG.md`
  - `LICENSE`
  - Proper `pubspec.yaml` metadata

---

## 🔁 Reusability Tip

Modularize everything:
- SVG icons in separate files
- Icon maps auto-generated
- Widget should be generic & extensible

Use GitHub Copilot for repetitive patterns like:
- `Map` generation
- Multiple widget constructors
- Asset path utilities

---

## 🏁 Done

When complete:
- Test across Flutter versions
- Validate on `pub.dev` (use `flutter pub publish --dry-run`)

Happy building 🚀