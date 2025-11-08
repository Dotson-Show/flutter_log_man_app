import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';
import '../../../widgets/inline_message_display.dart';
import '../../../widgets/modern_text_field.dart';
import '../../../widgets/modern_loading_button.dart';
import '../../../hooks/use_async_message_handler.dart';
import '../../../widgets/modern_dropdown_field.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final phoneController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isPasswordVisible = useState(false);
    final selectedUserType = useState<String?>(null);

    final (messageState, messageController) = useAsyncMessageHandler();
    final registerState = ref.watch(registerControllerProvider);

    // Listen to registration state changes with enhanced animations
    ref.listen<AsyncValue<void>>(
      registerControllerProvider,
          (previous, next) {
        next.when(
          data: (_) {
            messageController.showSuccess(
              "Account created successfully! Redirecting...",
              autoDismiss: const Duration(milliseconds: 1200),
            );
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (context.mounted) {
                context.go('/verify');
              }
            });
          },
          loading: () {
            messageController.showLoading("Creating your account...");
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
          'Create Account',
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
                // Welcome section
                _buildWelcomeSection(context),

                const SizedBox(height: 48),

                // Animated Message Display
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

                // Full Name field
                ModernTextField(
                  controller: nameController,
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  prefixIcon: Icons.person_outline_rounded,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your name';
                    }
                    if (value!.length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Email field
                ModernTextField(
                  controller: emailController,
                  label: 'Email Address',
                  hint: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Phone field
                ModernTextField(
                  controller: phoneController,
                  label: 'Phone Number',
                  hint: 'Enter your phone number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your phone number';
                    }
                    // Basic phone validation - adjust regex based on your requirements
                    if (!RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(value!.replaceAll(' ', ''))) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // User Type Dropdown
                ModernDropdownField<String>(
                  value: selectedUserType.value,
                  // label: 'Account Type',
                  hint: 'Select your account type',
                  prefixIcon: Icons.account_circle_outlined,
                  items: const [
                    DropdownItem(value: 'CLIENT', label: 'Client'),
                    DropdownItem(value: 'DRIVER', label: 'Driver'),
                    DropdownItem(value: 'VENDOR', label: 'Vendor'),
                    DropdownItem(value: 'MERCHANT', label: 'Merchant'),
                  ],
                  onChanged: (value) => selectedUserType.value = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your account type';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Password field
                ModernTextField(
                  controller: passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: !isPasswordVisible.value,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () => isPasswordVisible.value = !isPasswordVisible.value,
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a password';
                    }
                    if (value!.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
                      return 'Password must contain uppercase, lowercase and number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Password strength indicator
                _PasswordStrengthIndicator(password: passwordController.text),

                const SizedBox(height: 24),

                // Terms and conditions
                _buildTermsSection(context),

                const SizedBox(height: 24),

                // Register button with enhanced loading
                ModernLoadingButton(
                  onPressed: () => _handleRegistration(
                    formKey,
                    nameController,
                    emailController,
                    passwordController,
                    phoneController,
                    selectedUserType.value,
                    ref,
                    messageController,
                  ),
                  isLoading: registerState.isLoading,
                  loadingText: 'Creating account...',
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Divider
                _buildDivider(context),

                const SizedBox(height: 32),

                // Social registration options
                _buildSocialRegistrationSection(context),

                const SizedBox(height: 32),

                // Login link
                _buildLoginSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person_add_alt_1_rounded,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Join Us Today',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Create your account to get started',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsSection(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        children: [
          const TextSpan(text: 'By creating an account, you agree to our '),
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Theme.of(context).colorScheme.outline)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: Divider(color: Theme.of(context).colorScheme.outline)),
      ],
    );
  }

  Widget _buildSocialRegistrationSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ModernLoadingButton(
            type: ButtonType.outlined,
            onPressed: () {
              // TODO: Implement Google registration
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.g_mobiledata, size: 24),
                SizedBox(width: 8),
                Text('Google'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ModernLoadingButton(
            type: ButtonType.outlined,
            onPressed: () {
              // TODO: Implement Apple registration
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.apple, size: 24),
                SizedBox(width: 8),
                Text('Apple'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: () => context.go('/login'),
          child: const Text(
            'Sign In',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Future<void> _handleRegistration(
      GlobalKey<FormState> formKey,
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController phoneController,
      String? selectedUserType,
      WidgetRef ref,
      AsyncMessageController messageController,
      ) async {
    if (formKey.currentState?.validate() ?? false) {
      messageController.clearAll();
      await ref.read(registerControllerProvider.notifier).register(
        nameController.text.trim(),
        emailController.text.trim(),
        selectedUserType!,
        passwordController.text,
        phoneController.text.trim(),
      );
    }
  }
}

// ========================================
// PASSWORD STRENGTH INDICATOR WIDGET
// ========================================

class _PasswordStrengthIndicator extends HookWidget {
  const _PasswordStrengthIndicator({required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final strength = _calculatePasswordStrength(password);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    useEffect(() {
      animationController.animateTo(strength.score / 4);
      return null;
    }, [strength.score]);

    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Password Strength: ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              strength.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: strength.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return LinearProgressIndicator(
              value: animationController.value,
              backgroundColor: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(strength.color),
              minHeight: 4,
            );
          },
        ),
        if (strength.suggestions.isNotEmpty) ...[
          const SizedBox(height: 8),
          ...strength.suggestions.map((suggestion) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.circle,
                  size: 6,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    suggestion,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ],
    );
  }

  _PasswordStrength _calculatePasswordStrength(String password) {
    if (password.isEmpty) {
      return _PasswordStrength(
        score: 0,
        label: 'No password',
        color: Colors.grey,
        suggestions: [],
      );
    }

    int score = 0;
    List<String> suggestions = [];

    // Length check
    if (password.length >= 8) {
      score++;
    } else {
      suggestions.add('Use at least 8 characters');
    }

    // Uppercase check
    if (password.contains(RegExp(r'[A-Z]'))) {
      score++;
    } else {
      suggestions.add('Include uppercase letters');
    }

    // Lowercase check
    if (password.contains(RegExp(r'[a-z]'))) {
      score++;
    } else {
      suggestions.add('Include lowercase letters');
    }

    // Number check
    if (password.contains(RegExp(r'[0-9]'))) {
      score++;
    } else {
      suggestions.add('Include numbers');
    }

    // Special character check
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      score++;
    } else if (score >= 3) {
      suggestions.add('Include special characters for extra security');
    }

    return _PasswordStrength(
      score: score,
      label: _getStrengthLabel(score),
      color: _getStrengthColor(score),
      suggestions: suggestions,
    );
  }

  String _getStrengthLabel(int score) {
    switch (score) {
      case 0:
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
      case 5:
        return 'Strong';
      default:
        return 'Weak';
    }
  }

  Color _getStrengthColor(int score) {
    switch (score) {
      case 0:
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow[700]!;
      case 4:
      case 5:
        return Colors.green;
      default:
        return Colors.red;
    }
  }
}

class _PasswordStrength {
  final int score;
  final String label;
  final Color color;
  final List<String> suggestions;

  _PasswordStrength({
    required this.score,
    required this.label,
    required this.color,
    required this.suggestions,
  });
}