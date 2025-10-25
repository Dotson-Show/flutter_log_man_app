// FILE: lib/widgets/settings_section.dart
import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}