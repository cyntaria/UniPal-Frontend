// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/auth_provider.dart';

// States
import '../../shared/states/future_state.codegen.dart';

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
import '../../shared/widgets/custom_dialog.dart';
import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/custom_textfield.dart';
import '../../shared/widgets/scrollable_column.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final erpController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');

    void onData(bool? isAuthenticated) {
      if (isAuthenticated != null && isAuthenticated) {
        erpController.clear();
        passwordController.clear();
        AppRouter.popUntilRoot();
      }
    }

    ref.listen<FutureState<bool?>>(
      authProvider,
      (_, authState) => authState.whenOrNull(
        data: onData,
        failed: (reason) => CustomDialog.showAlertDialog(
          context: context,
          reason: reason,
          errorDialogTitle: 'Login Failed',
        ),
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
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
                    fontSize: 60,
                  ),
                ),
              ),

              Insets.gapH30,

              // ERP Input
              CustomTextField(
                controller: erpController,
                floatingText: 'ERP',
                hintText: 'Type your 5 digit erp',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: FormValidator.erpValidator,
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

              Insets.gapH30,

              // Login Button
              CustomTextButton.gradient(
                width: double.infinity,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    ref.read(authProvider.notifier).login(
                          erp: erpController.text,
                          password: passwordController.text,
                        );
                  }
                },
                gradient: AppColors.buttonGradientPurple,
                child: Consumer(
                  builder: (context, ref, child) {
                    final authState = ref.watch(authProvider);
                    return authState.maybeWhen(
                      loading: () => const CustomCircularLoader(),
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

              // Forgot Password Link
              Align(
                child: GestureDetector(
                  onTap: () {
                    AppRouter.pushNamed(Routes.ForgotPasswordScreenRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text.rich(
                      TextSpan(
                        text: 'Forgot your password? ',
                        children: [
                          TextSpan(
                            text: 'Reset Now',
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
