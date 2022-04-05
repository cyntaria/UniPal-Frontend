import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

// Providers
import '../../shared/widgets/custom_date_picker.dart';
import '../providers/auth_provider.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';
import '../../../helpers/form_validator.dart';

// Widgets
import '../../shared/widgets/custom_circular_loader.dart';
import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/custom_textfield.dart';
import '../../shared/widgets/scrollable_column.dart';

class UniversityDetailFields extends HookConsumerWidget {
  final GlobalKey<FormState> formKey;

  const UniversityDetailFields({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  void saveForm(
    WidgetRef ref, {
    required String uniEmail,
    required DateTime gradYear,
    required String program,
    required String campus,
  }) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ref.read(authProvider.notifier).saveUniversityDetails(
            uniEmail: uniEmail,
            gradYear: gradYear,
            program: program,
            campus: campus,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uniEmailController = useTextEditingController(text: '');
    final programController = useTextEditingController(text: '');
    final campusController = useTextEditingController(text: '');
    final gradYearController = useValueNotifier<DateTime?>(null);

    return ScrollableColumn(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Insets.expand,

        // Uni Email
        CustomTextField(
          controller: uniEmailController,
          floatingText: 'University Email',
          hintText: 'Type your university email address',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: FormValidator.emailValidator,
        ),

        Insets.gapH15,

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Graduation Year',
            style: AppTypography.primary.subHeading16.copyWith(
              color: AppColors.textBlackColor,
            ),
          ),
        ),

        Insets.gapH5,

        // Graduation Year
        CustomDatePicker(
          firstDate: DateTime(1980),
          dateNotifier: gradYearController,
          dateFormat: DateFormat.y(),
          helpText: 'SELECT YEAR OF GRADUATION',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialMaterialDatePickerMode: DatePickerMode.year,
          pickerStyle: const CustomDatePickerStyle(
            initialDateString: 'YYYY',
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
          onPressed: () => saveForm(
            ref,
            uniEmail: uniEmailController.text,
            gradYear: gradYearController.value!,
            program: programController.text,
            campus: campusController.text,
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
