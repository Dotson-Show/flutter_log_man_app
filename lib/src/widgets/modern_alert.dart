// ========================================
// 2. MODERN ALERT COMPONENT
// widgets/modern_alert.dart
// ========================================

import 'package:flutter/material.dart';

enum AlertType { error, success, warning, info }

class ModernAlert extends StatelessWidget {
  const ModernAlert({
    super.key,
    required this.message,
    required this.type,
    this.onDismiss,
    this.showIcon = true,
    this.suggestion,
  });

  final String message;
  final AlertType type;
  final VoidCallback? onDismiss;
  final bool showIcon;
  final String? suggestion;

  @override
  Widget build(BuildContext context) {
    final colors = _getAlertColors(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showIcon) ...[
                Icon(
                  _getAlertIcon(),
                  color: colors.iconColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: colors.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (onDismiss != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onDismiss,
                  child: Icon(
                    Icons.close,
                    color: colors.iconColor.withOpacity(0.7),
                    size: 18,
                  ),
                ),
              ],
            ],
          ),
          if (suggestion != null) ...[
            const SizedBox(height: 8),
            Text(
              suggestion!,
              style: TextStyle(
                color: colors.textColor.withOpacity(0.8),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getAlertIcon() {
    switch (type) {
      case AlertType.error:
        return Icons.error_outline;
      case AlertType.success:
        return Icons.check_circle_outline;
      case AlertType.warning:
        return Icons.warning_amber_outlined;
      case AlertType.info:
        return Icons.info_outline;
    }
  }

  _AlertColors _getAlertColors(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (type) {
      case AlertType.error:
        return _AlertColors(
          backgroundColor: colorScheme.errorContainer.withOpacity(0.1),
          borderColor: colorScheme.error.withOpacity(0.3),
          textColor: colorScheme.error,
          iconColor: colorScheme.error,
        );
      case AlertType.success:
        return _AlertColors(
          backgroundColor: const Color(0xFF4CAF50).withOpacity(0.1),
          borderColor: const Color(0xFF4CAF50).withOpacity(0.3),
          textColor: const Color(0xFF2E7D32),
          iconColor: const Color(0xFF4CAF50),
        );
      case AlertType.warning:
        return _AlertColors(
          backgroundColor: const Color(0xFFF57F17).withOpacity(0.1),
          borderColor: const Color(0xFFF57F17).withOpacity(0.3),
          textColor: const Color(0xFFE65100),
          iconColor: const Color(0xFFF57F17),
        );
      case AlertType.info:
        return _AlertColors(
          backgroundColor: colorScheme.primaryContainer.withOpacity(0.1),
          borderColor: colorScheme.primary.withOpacity(0.3),
          textColor: colorScheme.primary,
          iconColor: colorScheme.primary,
        );
    }
  }
}

class _AlertColors {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;

  _AlertColors({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
  });
}