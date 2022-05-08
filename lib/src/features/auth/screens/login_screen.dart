import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/auth_provider.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';
import '../../../helpers/form_validator.dart';

// Routing
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';

// Widgets
import '../../shared/widgets/custom_circular_loader.dart';
import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/custom_textfield.dart';
import '../../shared/widgets/scrollable_column.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: formKey,
          child: ScrollableColumn(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Align(
                child: Text(
                  'UniPal',
                  style: AppTypography.primary.heading34.copyWith(
                    fontSize: 50,
                  ),
                ),
              ),

              Insets.gapH30,

              // ERP-Email Input
              CustomTextField(
                controller: emailController,
                floatingText: 'ERP/Email',
                hintText: 'Type your ERP or email address',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: FormValidator.emailValidator,
              ),

              Insets.gapH10,

              // Password Input
              CustomTextField(
                controller: passwordController,
                floatingText: 'Password',
                hintText: 'Type your password',
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validator: FormValidator.passwordValidator,
              ),

              Insets.gapH5,

              // Forgot Password Link
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      AppRouter.pushNamed(Routes.ForgotPasswordScreenRoute);
                    },
                    child: Text(
                      'Forgot your password?',
                      style: AppTypography.primary.body16.copyWith(
                        color: AppColors.lightPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              Insets.gapH30,

              // Login Button
              CustomTextButton.gradient(
                width: double.infinity,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    ref.read(authProvider.notifier).login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  }
                },
                gradient: AppColors.buttonGradientPurple,
                child: Consumer(
                  builder: (context, ref, child) {
                    final authState = ref.watch(authProvider);
                    return authState.maybeWhen(
                      authenticating: () => const CustomCircularLoader(),
                      orElse: () => child!,
                    );
                  },
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: AppTypography.secondary.body16.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              Insets.gapH15,

              // Divider with "or"
              const Divider(
                color: Colors.black26,
                height: 5,
                indent: 15,
                endIndent: 15,
                thickness: 0.5,
              ),

              Insets.gapH10,

              // Register Link
              Align(
                child: GestureDetector(
                  onTap: () {
                    AppRouter.pushNamed(Routes.RegisterScreenRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account yet? ",
                        children: [
                          TextSpan(
                            text: 'Register now',
                            style: AppTypography.primary.body16.copyWith(
                              color: AppColors.lightPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      style: AppTypography.primary.body16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
