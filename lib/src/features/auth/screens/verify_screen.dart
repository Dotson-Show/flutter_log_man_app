import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../controllers/auth_controller.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/inline_message_display.dart';
import '../../../widgets/modern_loading_button.dart';
import '../../../hooks/use_async_message_handler.dart';

// part 'verify_screen.g.dart';

class VerifyScreen extends HookConsumerWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final resendTimer = useState(60);
    final canResend = useState(false);

    final verifyState = ref.watch(verifyControllerProvider);
    final (messageState, messageController) = useAsyncMessageHandler();

    // Countdown timer for resend functionality
    useEffect(() {
      if (resendTimer.value > 0) {
        final timer = Stream.periodic(const Duration(seconds: 1), (i) => i)
            .take(resendTimer.value)
            .listen((_) {
          if (resendTimer.value > 0) {
            resendTimer.value--;
          }
          if (resendTimer.value == 0) {
            canResend.value = true;
          }
        });
        return timer.cancel;
      }
      return null;
    }, [resendTimer.value]);

    // Listen to verification state changes
    ref.listen<AsyncValue<void>>(
      verifyControllerProvider,
      (previous, next) {
        next.when(
          data: (_) {
            messageController.showSuccess(
              'Phone verified successfully! Redirecting...',
              autoDismiss: const Duration(milliseconds: 1200),
            );
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (context.mounted) {
                context.go('/dashboard');
              }
            });
          },
          loading: () {
            messageController.showLoading('Verifying your phone...');
          },
          error: (error, _) {
            messageController.showError(error.toString());
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Verify Phone',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InlineMessageDisplay(
                  errorMessage: messageState.errorMessage,
                  successMessage: messageState.successMessage,
                  warningMessage: messageState.warningMessage,
                  infoMessage: messageState.infoMessage,
                  isLoading: messageState.isLoading,
                  loadingMessage: messageState.loadingMessage,
                  onDismissError: messageController.clearError,
                  onDismissSuccess: messageController.clearSuccess,
                  onDismissWarning: () => messageController.clearAll(),
                  onDismissInfo: () => messageController.clearAll(),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 20),

                // Verification icon and info
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.sms_outlined,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Enter Verification Code',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'We sent a verification code to your phone number.\nPlease enter the code below.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 48),

                // OTP Input Field
                TextFormField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 8,
                  ),
                  maxLength: 6,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the verification code';
                    }
                    if (value!.length < 6) {
                      return 'Please enter a valid 6-digit code';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Verification Code',
                    hintText: '000000',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                      letterSpacing: 8,
                    ),
                    prefixIcon: const Icon(Icons.verified_user_outlined),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    counterText: '',
                  ),
                ),

                const SizedBox(height: 32),

                // Verify button
                ModernLoadingButton(
                  onPressed: () => _handleVerification(
                    formKey,
                    otpController,
                    ref,
                    messageController,
                  ),
                  isLoading: verifyState.isLoading,
                  loadingText: 'Verifying your email ...',
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Resend code section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive the code? ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (canResend.value)
                      TextButton(
                        onPressed: () => _handleResendVerificationCode(
                          resendTimer,
                          canResend,
                          ref,
                          messageController,
                        ),
                        child: const Text(
                          'Resend',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )
                    else
                      Text(
                        'Resend in ${resendTimer.value}s',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 32),

                // Back to login
                TextButton.icon(
                  onPressed: () => context.go('/login'),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Back to Login'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleVerification(
      GlobalKey<FormState> formKey,
      TextEditingController otpController,
      WidgetRef ref,
      AsyncMessageController messageController,
      ) async {
    if (formKey.currentState?.validate() ?? false) {
      messageController.clearAll();
      await ref.read(verifyControllerProvider.notifier).verify(
        otpController.text.trim(),
      );
    }
  }

  Future<void> _handleResendVerificationCode(
  resendTimer,
  canResend,
      WidgetRef ref,
      AsyncMessageController messageController,
      ) async {
    messageController.clearAll();
    await ref.read(verifyControllerProvider.notifier).resendOtp();
    resendTimer.value = 60;
    canResend.value = false;
  }
}