// ========================================
// 3. INLINE MESSAGE DISPLAY WIDGET
// widgets/inline_message_display.dart
// ========================================

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'modern_alert.dart';
import '../utils/error_parser.dart';
import 'animated_loading_display.dart';

class InlineMessageDisplay extends HookWidget {
  const InlineMessageDisplay({
    super.key,
    this.errorMessage,
    this.successMessage,
    this.warningMessage,
    this.infoMessage,
    this.isLoading = false,
    this.loadingMessage,
    this.onDismissError,
    this.onDismissSuccess,
    this.onDismissWarning,
    this.onDismissInfo,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  final String? errorMessage;
  final String? successMessage;
  final String? warningMessage;
  final String? infoMessage;
  final bool isLoading;
  final String? loadingMessage;
  final VoidCallback? onDismissError;
  final VoidCallback? onDismissSuccess;
  final VoidCallback? onDismissWarning;
  final VoidCallback? onDismissInfo;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Loading Display
        AnimatedLoadingDisplay(
          isLoading: isLoading,
          message: loadingMessage,
        ),

        // Regular Messages
        AnimatedContainer(
          duration: animationDuration,
          height: _hasRegularMessage() ? null : 0,
          curve: Curves.easeInOut,
          child: _hasRegularMessage()
              ? Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                if (errorMessage != null)
                  ModernAlert(
                    message: errorMessage!,
                    type: AlertType.error,
                    onDismiss: onDismissError,
                    suggestion: ErrorParser.getSuggestion(errorMessage!),
                  ),
                if (successMessage != null) ...[
                  if (errorMessage != null) const SizedBox(height: 8),
                  _SuccessAlert(
                    message: successMessage!,
                    onDismiss: onDismissSuccess,
                  ),
                ],
                if (warningMessage != null) ...[
                  if (errorMessage != null || successMessage != null)
                    const SizedBox(height: 8),
                  ModernAlert(
                    message: warningMessage!,
                    type: AlertType.warning,
                    onDismiss: onDismissWarning,
                  ),
                ],
                if (infoMessage != null) ...[
                  if (errorMessage != null || successMessage != null || warningMessage != null)
                    const SizedBox(height: 8),
                  ModernAlert(
                    message: infoMessage!,
                    type: AlertType.info,
                    onDismiss: onDismissInfo,
                  ),
                ],
              ],
            ),
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  bool _hasRegularMessage() {
    return errorMessage != null ||
        successMessage != null ||
        warningMessage != null ||
        infoMessage != null;
  }
}

// Success Alert with special animation
class _SuccessAlert extends StatefulWidget {
  const _SuccessAlert({
    required this.message,
    this.onDismiss,
  });

  final String message;
  final VoidCallback? onDismiss;

  @override
  State<_SuccessAlert> createState() => _SuccessAlertState();
}

class _SuccessAlertState extends State<_SuccessAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _checkAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _checkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF4CAF50).withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            AnimatedBuilder(
              animation: _checkAnimation,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(24, 24),
                  painter: CheckmarkPainter(_checkAnimation.value),
                );
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.message,
                style: const TextStyle(
                  color: Color(0xFF2E7D32),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (widget.onDismiss != null) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: widget.onDismiss,
                child: const Icon(
                  Icons.close,
                  color: Color(0xFF4CAF50),
                  size: 18,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class CheckmarkPainter extends CustomPainter {
  final double progress;

  CheckmarkPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Draw circle background
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      Paint()
        ..color = const Color(0xFF4CAF50).withOpacity(0.2)
        ..style = PaintingStyle.fill,
    );

    // Draw checkmark
    if (progress > 0) {
      final checkPath = Path();
      checkPath.moveTo(size.width * 0.25, size.height * 0.5);

      if (progress > 0.5) {
        checkPath.lineTo(size.width * 0.45, size.height * 0.7);

        if (progress > 0.8) {
          checkPath.lineTo(size.width * 0.75, size.height * 0.3);
        } else {
          final endX = size.width * 0.45 + (size.width * 0.3 * ((progress - 0.5) / 0.3));
          final endY = size.height * 0.7 - (size.height * 0.4 * ((progress - 0.5) / 0.3));
          checkPath.lineTo(endX, endY);
        }
      } else {
        final endX = size.width * 0.25 + (size.width * 0.2 * (progress / 0.5));
        final endY = size.height * 0.5 + (size.height * 0.2 * (progress / 0.5));
        checkPath.lineTo(endX, endY);
      }

      canvas.drawPath(checkPath, paint);
    }
  }

  @override
  bool shouldRepaint(CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}