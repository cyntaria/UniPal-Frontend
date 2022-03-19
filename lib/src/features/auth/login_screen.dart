import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';
import '../../helpers/constants/app_styles.dart';
import '../../helpers/constants/app_typography.dart';
import '../../helpers/form_validator.dart';

// Routing
import '../../config/routes/app_router.dart';
import '../../config/routes/routes.dart';

// Widgets
import '../shared/widgets/custom_text_button.dart';
import '../shared/widgets/custom_textfield.dart';
import '../shared/widgets/scrollable_column.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ScrollableColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Text('UniPal', style: AppTypography.primary.heading34),

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
                    AppRouter.pushNamed(Routes.ForgotPasswordScreen);
                  },
                  child: Text(
                    'Forgot your password?',
                    style: AppTypography.primary.subHeading16.copyWith(
                      color: AppColors.lightPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),

            Insets.gapH10,

            // Login Button
            CustomTextButton.gradient(
              width: double.infinity,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  // ref.read(authProvider.notifier).login(
                  //       email: emailController.text,
                  //       password: passwordController.text,
                  //     );
                }
              },
              gradient: AppColors.buttonGradientPurple,
              child: Consumer(
                builder: (context, ref, child) {
                  return child!;
                  // final authState = ref.watch(authProvider);
                  // return authState.maybeWhen(
                  //   authenticating: () => const Center(
                  //     child: SpinKitRing(
                  //       color: Colors.white,
                  //       size: 30,
                  //       lineWidth: 4,
                  //       duration: Duration(milliseconds: 1100),
                  //     ),
                  //   ),
                  //   orElse: () => child!,
                  // );
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
              thickness: 0.5,
            ),

            Insets.gapH15,

            // Register Link
            GestureDetector(
              onTap: () {
                AppRouter.pushNamed(Routes.RegisterScreen);
              },
              child: Text.rich(
                TextSpan(
                  text: "Don't have an account yet? ",
                  children: [
                    TextSpan(
                      text: 'Register now',
                      style: AppTypography.primary.subHeading16.copyWith(
                        color: AppColors.lightPrimaryColor,
                      ),
                    ),
                  ],
                ),
                style: AppTypography.primary.subHeading16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
