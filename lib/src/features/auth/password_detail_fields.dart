import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';
import '../../helpers/constants/app_styles.dart';
import '../../helpers/constants/app_typography.dart';
import '../../helpers/form_validator.dart';

// Widgets
import '../shared/widgets/custom_text_button.dart';
import '../shared/widgets/custom_textfield.dart';

class PasswordDetailFields extends HookWidget {
  final GlobalKey<FormState> formKey;

  const PasswordDetailFields({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordController = useTextEditingController(text: '');
    final cPasswordController = useTextEditingController(text: '');

    return Column(
      children: [
        //Password
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

        //Confirm Password
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

        // Set Password Button
        CustomTextButton.gradient(
          width: double.infinity,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              // ref.read(authProvider.notifier).register(
              //       email: email,
              //       password: password,
              //       fullName: fullName,
              //       address: address,
              //       contact: contact,
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
