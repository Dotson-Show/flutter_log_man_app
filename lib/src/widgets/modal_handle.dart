// FILE: lib/widgets/modal_handle.dart
import 'package:flutter/material.dart';

/// A handle widget for modal bottom sheets that provides a visual indicator
/// for dragging and closing the modal.
class ModalHandle extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;

  const ModalHandle({
    super.key,
    this.width = 40,
    this.height = 4,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(height / 2),
        ),
      ),
    );
  }
}