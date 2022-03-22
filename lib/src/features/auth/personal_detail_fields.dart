import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../helpers/constants/app_assets.dart';
import '../../helpers/constants/app_colors.dart';
import '../../helpers/constants/app_styles.dart';
import '../../helpers/constants/app_typography.dart';
import '../../helpers/form_validator.dart';

// Widgets
import '../shared/widgets/custom_text_button.dart';
import '../shared/widgets/custom_textfield.dart';

class PersonalDetailFields extends HookWidget {
  final GlobalKey<FormState> formKey;

  const PersonalDetailFields({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final erpController = useTextEditingController(text: '');
    final firstNameController = useTextEditingController(text: '');
    final lastNameController = useTextEditingController(text: '');
    final genderController = useTextEditingController(text: '');
    final contactController = useTextEditingController(text: '');
    final emailController = useTextEditingController(text: '');
    late final DateTime birthday;

    Future<void> pickDate() async {
      final initialDate = DateTime.now();
      birthday = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(1950),
            lastDate: initialDate,
          ) ??
          initialDate;
    }

    return Column(
      children: [
        // ERP
        CustomTextField(
          controller: erpController,
          floatingText: 'ERP',
          hintText: 'Type your erp',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: FormValidator.erpValidator,
        ),

        Insets.gapH25,

        // First name
        CustomTextField(
          controller: firstNameController,
          floatingText: 'First name',
          hintText: 'Type your first name',
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: FormValidator.nameValidator,
        ),

        Insets.gapH25,

        // Last name
        CustomTextField(
          controller: lastNameController,
          floatingText: 'Last name',
          hintText: 'Type your last name',
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: FormValidator.nameValidator,
        ),

        Insets.gapH25,

        // Email
        CustomTextField(
          controller: emailController,
          floatingText: 'Email',
          hintText: 'Type your email address',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: FormValidator.emailValidator,
        ),

        Insets.gapH25,

        // Gender
        CustomTextField(
          controller: genderController,
          floatingText: 'Gender',
          hintText: 'Type your gender',
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: FormValidator.nameValidator,
        ),

        Insets.gapH25,

        // Contact
        CustomTextField(
          controller: contactController,
          floatingText: 'Contact',
          hintText: 'Type your mobile #',
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          validator: FormValidator.contactValidator,
          prefix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 0, 5, 0),
                child: Image.asset(AppAssets.pkFlag, width: 25),
              ),
              const Text(
                '+92',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textWhite80Color,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: VerticalDivider(thickness: 1.1, color: Colors.white),
              )
            ],
          ),
        ),

        // Birthday
        CustomTextButton.outlined(
          width: double.infinity,
          onPressed: pickDate,
          padding: const EdgeInsets.only(left: 20, right: 15),
          border: Border.all(color: AppColors.primaryColor, width: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Select Birthday',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 15,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),

              //Arrow
              Icon(
                Icons.calendar_today_rounded,
                size: IconSizes.med24,
                color: AppColors.primaryColor,
              )
            ],
          ),
        ),

        // Confirm Details Button
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
