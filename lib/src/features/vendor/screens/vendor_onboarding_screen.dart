import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../controllers/vendor_controller.dart';
import '../../../widgets/inline_message_display.dart';
import '../../../hooks/use_async_message_handler.dart';

part 'vendor_onboarding_screen.g.dart';

@riverpod
class VendorOnboardingController extends _$VendorOnboardingController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> registerVendor({
    required String companyName,
    required String taxId,
    required String businessLicense,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(vendorOnboardingControllerProvider.notifier).registerVendor(
        companyName: companyName,
        taxId: taxId,
        businessLicense: businessLicense,
        email: email,
        phone: phone,
        password: password,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

class VendorOnboardingScreen extends HookConsumerWidget {
  const VendorOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyNameController = useTextEditingController();
    final taxIdController = useTextEditingController();
    final businessLicenseController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isPasswordVisible = useState(false);

    final onboardingState = ref.watch(vendorOnboardingControllerProvider);
    final (messageState, messageController) = useAsyncMessageHandler();

    ref.listen<AsyncValue<void>>(
      vendorOnboardingControllerProvider,
      (previous, next) {
        next.when(
          data: (_) {
            messageController.showSuccess(
              'Registration submitted. Pending admin approval.',
              autoDismiss: const Duration(milliseconds: 1800),
            );
          },
          loading: () {
            messageController.showLoading('Submitting your registration...');
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
        title: const Text('Vendor Registration', style: TextStyle(fontWeight: FontWeight.w600)),
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
                Column(
                  children: [
                    Icon(Icons.business, size: 64, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 16),
                    Text('Register as a Vendor',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            )),
                    const SizedBox(height: 8),
                    Text('Submit your business details to get started',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            )),
                  ],
                ),
                const SizedBox(height: 48),
                _ModernTextField(
                  controller: companyNameController,
                  label: 'Company Name',
                  prefixIcon: Icons.business_outlined,
                  validator: (value) => (value?.isEmpty ?? true) ? 'Please enter your company name' : null,
                ),
                const SizedBox(height: 20),
                _ModernTextField(
                  controller: taxIdController,
                  label: 'Tax ID',
                  prefixIcon: Icons.numbers,
                  validator: (value) => (value?.isEmpty ?? true) ? 'Please enter your tax ID' : null,
                ),
                const SizedBox(height: 20),
                _ModernTextField(
                  controller: businessLicenseController,
                  label: 'Business License',
                  prefixIcon: Icons.description_outlined,
                  validator: (value) => (value?.isEmpty ?? true) ? 'Please enter your business license' : null,
                ),
                const SizedBox(height: 20),
                _ModernTextField(
                  controller: emailController,
                  label: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please enter your email';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4} [0m').hasMatch(value!)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _ModernTextField(
                  controller: phoneController,
                  label: 'Phone Number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) => (value?.isEmpty ?? true) ? 'Please enter your phone number' : null,
                ),
                const SizedBox(height: 20),
                _ModernTextField(
                  controller: passwordController,
                  label: 'Password',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: !isPasswordVisible.value,
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordVisible.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: () => isPasswordVisible.value = !isPasswordVisible.value,
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please enter a password';
                    if (value!.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: onboardingState.isLoading
                      ? null
                      : () async {
                          if (formKey.currentState?.validate() ?? false) {
                            await ref.read(vendorOnboardingControllerProvider.notifier).registerVendor(
                                  companyName: companyNameController.text.trim(),
                                  taxId: taxIdController.text.trim(),
                                  businessLicense: businessLicenseController.text.trim(),
                                  email: emailController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  password: passwordController.text,
                                );
                          }
                        },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: onboardingState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text(
                          'Register',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModernTextField extends StatelessWidget {
  const _ModernTextField({
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}




