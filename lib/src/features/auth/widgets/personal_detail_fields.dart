import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

// Providers
import '../providers/auth_provider.dart';

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
import '../../shared/widgets/custom_circular_loader.dart';
import '../../shared/widgets/custom_date_picker.dart';
import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/custom_textfield.dart';
import '../../shared/widgets/scrollable_column.dart';
import './gender_selection_cards.dart';

class PersonalDetailFields extends HookConsumerWidget {
  final GlobalKey<FormState> formKey;

  const PersonalDetailFields({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  void saveForm(
    WidgetRef ref, {
    required String erp,
    required String firstName,
    required String lastName,
    required String contact,
    required String email,
    required DateTime birthday,
  }) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ref.read(authProvider.notifier).savePersonalDetails(
            erp: erp,
            firstName: firstName,
            lastName: lastName,
            contact: contact,
            email: email,
            birthday: birthday,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final erpController = useTextEditingController(text: '');
    final firstNameController = useTextEditingController(text: '');
    final lastNameController = useTextEditingController(text: '');
    final contactController = useTextEditingController(text: '');
    final emailController = useTextEditingController(text: '');
    final birthdayController = useValueNotifier<DateTime?>(null);

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
              color: AppColors.primaryColor,
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

        // Names
        Row(
          children: [
            // First name
            Expanded(
              flex: 6,
              child: CustomTextField(
                controller: firstNameController,
                floatingText: 'First name',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: FormValidator.nameValidator,
              ),
            ),

            Insets.gapW15,

            // Last name
            Expanded(
              flex: 5,
              child: CustomTextField(
                controller: lastNameController,
                floatingText: 'Last name',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: FormValidator.nameValidator,
              ),
            ),
          ],
        ),

        Insets.gapH15,

        // Email
        CustomTextField(
          controller: emailController,
          floatingText: 'Email',
          hintText: 'Type your personal email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: FormValidator.emailValidator,
        ),

        Insets.gapH15,

        // Gender Label
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Gender',
            style: AppTypography.primary.body16.copyWith(
              color: AppColors.textBlackColor,
            ),
          ),
        ),

        Insets.gapH5,

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
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 0, 5, 0),
                child: Image.asset(AppAssets.pkFlag, width: 25),
              ),
              const Text(
                '+92',
                style: TextStyle(fontSize: 16),
              ),
              const VerticalDivider(
                thickness: 1.2,
                width: 18,
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
              )
            ],
          ),
        ),

        Insets.gapH15,

        // Birthday
        CustomDatePicker(
          firstDate: DateTime(1950),
          dateNotifier: birthdayController,
          dateFormat: DateFormat('d MMMM, y'),
          helpText: 'SELECT BIRTHDAY',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          pickerStyle: const CustomDatePickerStyle(
            initialDateString: 'DD MONTH, YYYY',
            floatingText: 'Birthday',
          ),
        ),

        Insets.expand,

        // Confirm Details Button
        CustomTextButton.gradient(
          width: double.infinity,
          onPressed: () => saveForm(
            ref,
            erp: erpController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            contact: contactController.text,
            email: emailController.text,
            birthday: birthdayController.value!,
          ),
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
