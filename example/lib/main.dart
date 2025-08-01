import 'package:flutter/material.dart';
import 'package:vuesax_flutter_icons/vuesax_flutter_icons.dart';

void main() {
  runApp(const VuesaxIconsExample());
}

class VuesaxIconsExample extends StatelessWidget {
  const VuesaxIconsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vuesax Flutter Icons Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const IconDemoPage(),
    );
  }
}

class IconDemoPage extends StatefulWidget {
  const IconDemoPage({Key? key}) : super(key: key);

  @override
  State<IconDemoPage> createState() => _IconDemoPageState();
}

class _IconDemoPageState extends State<IconDemoPage> {
  double _iconSize = VuesaxConfig.defaultSize;
  Color _iconColor = Colors.blue;
  VuesaxVariant _selectedVariant = VuesaxVariant.linear;
  bool _useNetworkIcons = VuesaxConfig.preferCDN;
  bool _debugMode = VuesaxConfig.enableDebugLogging;

  final Map<VuesaxVariant, String> _variantExamples = {
    VuesaxVariant.bold: VuesaxIcons.activity,
    VuesaxVariant.outline: VuesaxIcons.activity,
    VuesaxVariant.linear: VuesaxIcons.activity,
    VuesaxVariant.bulk: VuesaxIcons.activity,
    VuesaxVariant.twotone: VuesaxIcons.activity,
    VuesaxVariant.broken: VuesaxIcons.activity,
  };

  final List<Color> _colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.black,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vuesax Flutter Icons'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CDN Configuration Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CDN Configuration',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Base CDN: ${VuesaxConfig.baseCDN}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Repository: ${VuesaxConfig.githubUsername}/${VuesaxConfig.repositoryName}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Branch: ${VuesaxConfig.branch}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            // Icon source toggle
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Icon Source',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Switch(
                          value: _useNetworkIcons,
                          onChanged: (value) {
                            setState(() {
                              _useNetworkIcons = value;
                            });
                          },
                        ),
                        const SizedBox(width: 8.0),
                        Text(_useNetworkIcons
                            ? 'CDN Icons (Network)'
                            : 'Local Assets'),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      _useNetworkIcons
                          ? '🌐 Loading icons from GitHub CDN with caching'
                          : '📱 Using bundled local assets',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('Debug Logging: '),
                        Switch(
                          value: _debugMode,
                          onChanged: (value) {
                            setState(() {
                              _debugMode = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            // Main showcase icon
            Center(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: VuesaxIcon.icon(
                  _selectedVariant,
                  _variantExamples[_selectedVariant]!,
                  size: _iconSize,
                  color: _iconColor,
                  useLocalAssets: !_useNetworkIcons,
                  key: ValueKey('icon_${_selectedVariant.value}_${_variantExamples[_selectedVariant]}'),
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            // Current CDN URL display
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current URL:',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    VuesaxConfig.buildCDNUrl(
                        _selectedVariant.value, _variantExamples[_selectedVariant]!),
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32.0),

            // Controls
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customization Options',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16.0),

                    // Size slider
                    Text('Size: ${_iconSize.round()}px'),
                    Slider(
                      value: _iconSize,
                      min: 16.0,
                      max: 128.0,
                      divisions: 14,
                      onChanged: (value) {
                        setState(() {
                          _iconSize = value;
                        });
                      },
                    ),

                    const SizedBox(height: 16.0),

                    // Variant selector
                    Text('Variant:'),
                    const SizedBox(height: 8.0),
                    Wrap(
                      spacing: 8.0,
                      children: VuesaxVariant.values.map((variant) {
                        return ChoiceChip(
                          label: Text(variant.value.toUpperCase()),
                          selected: _selectedVariant == variant,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedVariant = variant;
                              });
                            }
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16.0),

                    // Color selector
                    Text('Color:'),
                    const SizedBox(height: 8.0),
                    Wrap(
                      spacing: 8.0,
                      children: _colorOptions.map((color) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _iconColor = color;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: _iconColor == color
                                  ? Border.all(color: Colors.black, width: 3)
                                  : Border.all(color: Colors.grey.shade300),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24.0),

            // Icon showcase grid
            Text(
              'Icon Examples',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),

            _buildIconShowcase(),

            const SizedBox(height: 24.0),

            // Usage examples
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Usage Examples',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '// NEW: Type-safe API (Recommended)\n'
                            'VuesaxIcon.icon(\n'
                            '  VuesaxVariant.linear,\n'
                            '  VuesaxIcons.home,\n'
                            '  size: 32,\n'
                            '  color: Colors.blue,\n'
                            ')\n\n'
                            '// Legacy: String-based\n'
                            'VuesaxIcon(\n'
                            '  variant: "linear",\n'
                            '  iconName: "home",\n'
                            '  size: 32,\n'
                            ')\n\n'
                            '// Using iconId (legacy)\n'
                            'VuesaxIcon(\n'
                            '  iconId: LegacyVuesaxIcons.boldActivity,\n'
                            ')',
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 12,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '// Type-safe variants:\n'
                            '${VuesaxVariant.values.map((v) => 'VuesaxVariant.${v.name}').join(', ')}\n\n'
                            '// Popular icons:\n'
                            'VuesaxIcons.home, VuesaxIcons.user, VuesaxIcons.heart\n'
                            'VuesaxIcons.search, VuesaxIcons.settings, VuesaxIcons.notification\n\n'
                            '// CDN Configuration in VuesaxConfig:\n'
                            '// - githubUsername, repositoryName, branch\n'
                            '// - Enable/disable CDN, debug logging, caching',
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 12,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconShowcase() {
    final showcaseIcons = [
      'activity',
      'home',
      'user',
      'heart',
      'search-normal',
      'setting',
      'calendar',
      'message',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.0,
      ),
      itemCount: showcaseIcons.length,
      itemBuilder: (context, index) {
        final iconName = showcaseIcons[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: VuesaxIcon(
                variant: 'bold',
                iconName: iconName,
                size: 32,
                color: Colors.grey.shade700,
                useLocalAssets: !_useNetworkIcons,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              iconName,
              style: const TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
