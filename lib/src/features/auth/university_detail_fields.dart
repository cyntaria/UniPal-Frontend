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

class UniversityDetailFields extends HookWidget {
  final GlobalKey<FormState> formKey;

  const UniversityDetailFields({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uniEmailController = useTextEditingController(text: '');

    late final DateTime gradYear;

    Future<void> pickDate() async {
      final initialDate = DateTime.now();
      gradYear = await showDatePicker(
            context: context,
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            initialDatePickerMode: DatePickerMode.year,
            initialDate: initialDate,
            firstDate: DateTime(1980),
            lastDate: initialDate,
          ) ??
          initialDate;
    }

    return Column(
      children: [
        // Uni Email
        CustomTextField(
          controller: uniEmailController,
          floatingText: 'Email',
          hintText: 'Type your university email address',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: FormValidator.emailValidator,
        ),

        Insets.gapH25,

        // Graduation Year
        CustomTextButton.outlined(
          width: double.infinity,
          onPressed: pickDate,
          padding: const EdgeInsets.only(left: 20, right: 15),
          border: Border.all(color: AppColors.primaryColor, width: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Select Graduation Year',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 15,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),

              //Arrow
              Icon(
                Icons.calendar_view_day_rounded,
                color: AppColors.primaryColor,
              )
            ],
          ),
        ),

        Insets.gapH25,

        // TODO(arafaysaleem): Program Dropdown

        Insets.gapH25,

        // TODO(arafaysaleem): Campus Dropdown

        Insets.expand,

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
                'NEXT',
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
