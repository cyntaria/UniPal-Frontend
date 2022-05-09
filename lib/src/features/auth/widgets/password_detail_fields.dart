// ignore_for_file: avoid_positional_boolean_parameters

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

// Widgets
import '../../shared/widgets/custom_dialog.dart';
import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/custom_circular_loader.dart';
import '../../shared/widgets/custom_textfield.dart';
import '../../shared/widgets/scrollable_column.dart';

class PasswordDetailFields extends HookConsumerWidget {
  final GlobalKey<FormState> formKey;

  const PasswordDetailFields({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  void saveForm(WidgetRef ref, {required String password}) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ref.read(authProvider.notifier).register(
            password: password,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController = useTextEditingController(text: '');
    final cPasswordController = useTextEditingController(text: '');

    void onData(bool isAuthenticated) {
      if (isAuthenticated) {
        passwordController.clear();
        cPasswordController.clear();
        AppRouter.popUntilRoot();
      }
    }

    ref.listen<AsyncValue<bool>>(
      authProvider,
      (_, authState) => authState.whenOrNull(
        data: onData,
        error: (reason, stackTrace) => CustomDialog.showAlertDialog(
          context: context,
          reason: reason as String,
          stackTrace: stackTrace,
          errorButtonText: 'Register Failed',
        ),
      ),
    );
    return ScrollableColumn(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Insets.expand,

        // Password
        CustomTextField(
          controller: passwordController,
          autofocus: true,
          floatingText: 'Password',
          hintText: 'Type your password',
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          validator: FormValidator.passwordValidator,
        ),

        Insets.gapH25,

        // Confirm Password
        CustomTextField(
          controller: cPasswordController,
          floatingText: 'Confirm Password',
          hintText: 'Retype your password',
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          validator: (confirmPw) => FormValidator.confirmPasswordValidator(
            confirmPw,
            passwordController.text,
          ),
        ),

        Insets.expand,

        // Set Password Button
        CustomTextButton.gradient(
          width: double.infinity,
          onPressed: () => saveForm(
            ref,
            password: passwordController.text,
          ),
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
                'CONFIRM',
                style: AppTypography.secondary.body16.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
