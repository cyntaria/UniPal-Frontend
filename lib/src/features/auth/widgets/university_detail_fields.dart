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

    Future<void> pickDate() async {
      final initialDate = DateTime.now();
      gradYearController.value = await showDatePicker(
            context: context,
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            initialDatePickerMode: DatePickerMode.year,
            initialDate: initialDate,
            firstDate: DateTime(1980),
            lastDate: initialDate,
          ) ??
          initialDate;
    }

    return ScrollableColumn(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Insets.expand,

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
            children: [
              ValueListenableBuilder<DateTime?>(
                valueListenable: gradYearController,
                builder: (_, gradYear, __) {
                  var gradYr = 'Select Graduation Year';
                  if (gradYear != null) {
                    gradYr = DateFormat.y().format(gradYear);
                  }
                  return Text(
                    gradYr,
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
