# 🎯 **Type-Safe Vuesax Flutter Icons API**

## ✨ **New Recommended Usage**

### **Type-Safe Approach (Recommended)**

```dart
import 'package:vuesax_flutter_icons/vuesax_flutter_icons.dart';

// ✅ Recommended: Type-safe enum API
VuesaxIcon.icon(
  VuesaxVariant.linear,    // 🎯 Enum with autocomplete
  VuesaxIcons.home,        // 🎯 Type-safe icon constant
  size: 32,
  color: Colors.blue,
)

// ✅ All variants available
VuesaxIcon.icon(VuesaxVariant.bold, VuesaxIcons.heart)
VuesaxIcon.icon(VuesaxVariant.outline, VuesaxIcons.user)
VuesaxIcon.icon(VuesaxVariant.linear, VuesaxIcons.search)
VuesaxIcon.icon(VuesaxVariant.bulk, VuesaxIcons.notification)
VuesaxIcon.icon(VuesaxVariant.twotone, VuesaxIcons.settings)
VuesaxIcon.icon(VuesaxVariant.broken, VuesaxIcons.activity)
```

### **Available Variants**

```dart
enum VuesaxVariant {
  bold,      // VuesaxVariant.bold
  outline,   // VuesaxVariant.outline
  linear,    // VuesaxVariant.linear
  bulk,      // VuesaxVariant.bulk
  twotone,   // VuesaxVariant.twotone
  broken,    // VuesaxVariant.broken
}
```

### **Type-Safe Icon Constants**

```dart
class VuesaxIcons {
  // Core essentials
  static const String home = 'home';
  static const String user = 'user';
  static const String activity = 'activity';
  static const String heart = 'heart';
  static const String search = 'search-normal';
  static const String settings = 'setting';
  static const String notification = 'notification';
  static const String calendar = 'calendar';
  static const String message = 'message';
  static const String profile = 'profile';

  // UI Actions
  static const String add = 'add';
  static const String edit = 'edit';
  static const String delete = 'trash';
  static const String save = 'save-2';
  static const String copy = 'copy';
  static const String share = 'share';
  static const String download = 'document-download';
  static const String upload = 'document-upload';

  // Navigation
  static const String menu = 'menu';
  static const String arrowLeft = 'arrow-left';
  static const String arrowRight = 'arrow-right';
  static const String arrowUp = 'arrow-up';
  static const String arrowDown = 'arrow-down';
  static const String back = 'arrow-left';
  static const String next = 'next';
  static const String previous = 'previous';

  // Media
  static const String play = 'play';
  static const String pause = 'pause';
  static const String stop = 'stop';
  static const String music = 'music';
  static const String video = 'video';
  static const String camera = 'camera';
  static const String gallery = 'gallery';

  // Communication
  static const String call = 'call';
  static const String email = 'message';
  static const String chat = 'message';
  static const String send = 'send';

  // Business
  static const String money = 'money';
  static const String wallet = 'wallet';
  static const String shop = 'shop';
  static const String bag = 'bag';
  static const String card = 'card';
  static const String chart = 'chart';

  // System
  static const String security = 'security';
  static const String lock = 'lock';
  static const String unlock = 'unlock';
  static const String key = 'key';
  static const String shield = 'shield';
  static const String warning = 'warning-2';
  static const String info = 'info-circle';
  static const String check = 'check';
  static const String close = 'close-circle';

  // ... 600+ more icons available!
}
```

## 🔄 **Migration Guide**

### **From String-based to Type-safe**

```dart
// ❌ Old way (still works, but not recommended)
VuesaxIcon(
  variant: 'linear',           // String prone to typos
  iconName: 'home',           // String prone to typos
  size: 32,
)

// ✅ New way (recommended)
VuesaxIcon.icon(
  VuesaxVariant.linear,       // ✨ Enum with autocomplete
  VuesaxIcons.home,          // ✨ Type-safe constant
  size: 32,
)
```

### **Backward Compatibility**

All existing code continues to work! The new API is additive:

```dart
// ✅ Legacy approach (still supported)
VuesaxIcon(variant: 'linear', iconName: 'home')
VuesaxIcon(iconId: 'linear/home')
VuesaxIcon.variant('bold', 'user')

// ✅ New approach (recommended)
VuesaxIcon.icon(VuesaxVariant.linear, VuesaxIcons.home)
```

## 🎯 **Benefits of Type-Safe API**

| Feature              | String-based           | Type-safe API           |
| -------------------- | ---------------------- | ----------------------- |
| **IDE Autocomplete** | ❌ None                | ✅ Full support         |
| **Typo Prevention**  | ❌ Runtime errors      | ✅ Compile-time safety  |
| **Refactoring**      | ❌ Manual find/replace | ✅ IDE handles it       |
| **Documentation**    | ❌ Need to check docs  | ✅ Built-in suggestions |
| **Code Readability** | ⚠️ Magic strings       | ✅ Self-documenting     |

## 📚 **Real-World Examples**

### **Navigation Icons**

```dart
AppBar(
  leading: VuesaxIcon.icon(VuesaxVariant.linear, VuesaxIcons.menu),
  actions: [
    IconButton(
      icon: VuesaxIcon.icon(VuesaxVariant.outline, VuesaxIcons.search),
      onPressed: () => showSearch(),
    ),
    IconButton(
      icon: VuesaxIcon.icon(VuesaxVariant.linear, VuesaxIcons.notification),
      onPressed: () => showNotifications(),
    ),
  ],
)
```

### **Form Actions**

```dart
Row(
  children: [
    ElevatedButton.icon(
      icon: VuesaxIcon.icon(VuesaxVariant.bold, VuesaxIcons.save),
      label: Text('Save'),
      onPressed: save,
    ),
    TextButton.icon(
      icon: VuesaxIcon.icon(VuesaxVariant.linear, VuesaxIcons.close),
      label: Text('Cancel'),
      onPressed: cancel,
    ),
  ],
)
```

### **Dynamic Icon Selection**

```dart
class IconPicker extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _popularIcons.length,
      itemBuilder: (context, index) {
        final iconName = _popularIcons[index];
        return GestureDetector(
          onTap: () => selectIcon(iconName),
          child: VuesaxIcon.icon(
            _selectedVariant,  // Dynamic variant
            iconName,          // Type-safe icon name
            size: 32,
          ),
        );
      },
    );
  }

  final List<String> _popularIcons = [
    VuesaxIcons.home,
    VuesaxIcons.user,
    VuesaxIcons.heart,
    VuesaxIcons.search,
    VuesaxIcons.settings,
    VuesaxIcons.notification,
    // Type-safe list!
  ];
}
```

## 🚀 **Get Started**

1. **Update your imports**:

   ```dart
   import 'package:vuesax_flutter_icons/vuesax_flutter_icons.dart';
   ```

2. **Start using the new API**:

   ```dart
   VuesaxIcon.icon(VuesaxVariant.linear, VuesaxIcons.home)
   ```

3. **Enjoy IDE autocomplete and type safety!** 🎉

---

**The new type-safe API makes Vuesax Flutter Icons more developer-friendly while maintaining full backward compatibility. Happy coding! 🚀**
