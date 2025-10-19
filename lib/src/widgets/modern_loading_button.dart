// ========================================
// 5. MODERN LOADING BUTTON WIDGET
// widgets/modern_loading_button.dart
// ========================================
import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class ModernLoadingButton extends StatelessWidget {
  const ModernLoadingButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.loadingText,
    this.style,
    this.type = ButtonType.filled,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final String? loadingText;
  final ButtonStyle? style;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = type == ButtonType.filled
        ? FilledButton.styleFrom(
      backgroundColor: const Color(0xFF1F1F1F),
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    )
        : OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final Widget buttonChild = isLoading
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 16,
          width: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: type == ButtonType.filled
                ? Colors.white
                : Theme.of(context).colorScheme.primary,
          ),
        ),
        if (loadingText != null) ...[
          const SizedBox(width: 12),
          Text(
            loadingText!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: type == ButtonType.filled
                  ? Colors.white.withOpacity(0.8)
                  : Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ),
          ),
        ],
      ],
    )
        : child;

    return type == ButtonType.filled
        ? FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: style ?? defaultStyle,
      child: buttonChild,
    )
        : OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: style ?? defaultStyle,
      child: buttonChild,
    );
  }
}

enum ButtonType { filled, outlined }