import 'package:flutter_test/flutter_test.dart';
import 'package:vuesax_flutter_icons/vuesax_flutter_icons.dart';

void main() {
  group('Vuesax Flutter Icons', () {
    test('BoldIcons should have activity icon path', () {
      expect(BoldIcons.activity, equals('assets/Svg/All/bold/activity.svg'));
    });

    test('OutlineIcons should have activity icon path', () {
      expect(
          OutlineIcons.activity, equals('assets/Svg/All/outline/activity.svg'));
    });

    test('CustomSvgIcon should accept required parameters', () {
      expect(() => const CustomSvgIcon(assetPath: 'test/path.svg'),
          returnsNormally);
    });
  });
}
