import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

// Providers
import '../providers/auth_provider.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';
import '../../../helpers/form_validator.dart';

// Widgets
import '../../shared/widgets/custom_dropdown_field.dart';
import '../../shared/widgets/custom_dropdown_sheet.dart';
import '../../shared/widgets/custom_date_picker.dart';
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
    final gradYearController = useValueNotifier<DateTime?>(null);
    final programController = useValueNotifier<int?>(null);
    final campusController = useValueNotifier<int?>(null);

    return ScrollableColumn(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Insets.expand,

        // Uni Email
        CustomTextField(
          controller: uniEmailController,
          floatingText: 'University Email',
          hintText: 'Type your iba email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: FormValidator.emailValidator,
        ),

        Insets.gapH15,

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
            floatingText: 'Graduation Year',
          ),
        ),

        Insets.gapH15,

        // Program Dropdown
        CustomDropdownField<int>(
          controller: programController,
          selectedItemText: (item) => '$item',
          hintText: 'Select a degree',
          floatingText: 'Programs',
          itemsSheet: CustomDropdownSheet(
            items: const [1, 2, 3],
            bottomSheetTitle: 'Programs',
            itemBuilder: (_, item) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text('$item'),
                ),
              );
            },
          ),
        ),

        Insets.gapH15,

        // Campus Dropdown
        CustomDropdownField<int>(
          controller: campusController,
          selectedItemText: (item) => '$item',
          floatingText: 'Campuses',
          itemsSheet: CustomDropdownSheet(
            items: const [1, 2, 3],
            bottomSheetTitle: 'Campuses',
            itemBuilder: (_, item) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text('$item'),
                ),
              );
            },
          ),
        ),

        Insets.expand,

        // Confirm Details Button
        CustomTextButton.gradient(
          width: double.infinity,
          onPressed: () => saveForm(
            ref,
            uniEmail: uniEmailController.text,
            gradYear: gradYearController.value!,
            program: '${programController.value}',
            campus: '${campusController.value}',
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
