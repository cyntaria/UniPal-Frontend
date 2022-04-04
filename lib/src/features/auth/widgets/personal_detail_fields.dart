import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

// Routing
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';

// Helpers
import '../../../helpers/constants/app_assets.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';
import '../../../helpers/form_validator.dart';

// Widgets
import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/custom_textfield.dart';
import '../../shared/widgets/scrollable_column.dart';
import './gender_selection_cards.dart';

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
    final contactController = useTextEditingController(text: '');
    final emailController = useTextEditingController(text: '');
    final birthdayController = useValueNotifier<DateTime?>(null);

    Future<void> pickDate() async {
      final initialDate = DateTime.now();
      birthdayController.value = await showDatePicker(
            context: context,
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            initialDate: initialDate,
            firstDate: DateTime(1950),
            lastDate: initialDate,
          ) ??
          initialDate;
    }

    return ScrollableColumn(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Insets.expand,

        // ERP
        CustomTextField(
          controller: erpController,
          readOnly: true,
          floatingText: 'ERP',
          hintText: 'Scan your IBA ID card',
          validator: FormValidator.erpValidator,
          suffix: IconButton(
            icon: const Icon(
              Icons.qr_code_scanner_rounded,
              color: AppColors.tertiaryColor,
              size: IconSizes.med22,
            ),
            onPressed: () async {
              final qrCode = await AppRouter.pushNamed(
                Routes.QrScannerScreen,
              ) as String;
              erpController.text = qrCode;
            },
          ),
        ),

        Insets.gapH15,

        // First name
        CustomTextField(
          controller: firstNameController,
          floatingText: 'First name',
          hintText: 'Type your first name',
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: FormValidator.nameValidator,
        ),

        Insets.gapH15,

        // Last name
        CustomTextField(
          controller: lastNameController,
          floatingText: 'Last name',
          hintText: 'Type your last name',
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: FormValidator.nameValidator,
        ),

        Insets.gapH15,

        // Email
        CustomTextField(
          controller: emailController,
          floatingText: 'Email',
          hintText: 'Type your email address',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: FormValidator.emailValidator,
        ),

        Insets.gapH20,

        // Gender
        const GenderSelectionCards(),

        Insets.gapH15,

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
            children: const [
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(17, 0, 5, 0),
              //   child: Image.asset(AppAssets.pkFlag, width: 25),
              // ),
              Text(
                '+92',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textWhite80Color,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: VerticalDivider(thickness: 1.1, color: Colors.white),
              )
            ],
          ),
        ),

        Insets.gapH20,

        // Birthday
        CustomTextButton.outlined(
          width: double.infinity,
          onPressed: pickDate,
          padding: const EdgeInsets.only(left: 20, right: 15),
          border: Border.all(color: AppColors.primaryColor, width: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder<DateTime?>(
                valueListenable: birthdayController,
                builder: (_, birthday, __) {
                  var bday = 'Select Birthday';
                  if (birthday != null) {
                    bday = DateFormat('d MMMM y').format(birthday);
                  }
                  return Text(
                    bday,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 15,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),

              //Arrow
              const Icon(
                Icons.calendar_today_rounded,
                color: AppColors.primaryColor,
              )
            ],
          ),
        ),

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
