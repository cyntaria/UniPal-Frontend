import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../profile/models/campus_model.codegen.dart';
import '../../profile/models/program_model.codegen.dart';
import '../../profile/providers/campuses_provider.dart';
import '../../profile/providers/programs_provider.dart';
import '../providers/register_form_provider.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

// Widgets
import '../../shared/widgets/dropdown_sheet_item.dart';
import '../../shared/widgets/labeled_widget.dart';
import '../../shared/widgets/custom_dropdown_field.dart';
import '../../shared/widgets/custom_dropdown_sheet.dart';
import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/scrollable_column.dart';

class UniversityDetailFields extends HookConsumerWidget {
  final GlobalKey<FormState> formKey;

  const UniversityDetailFields({
    super.key,
    required this.formKey,
  });

  void saveForm(
    WidgetRef ref, {
    required int gradYear,
    required ProgramModel programId,
    required CampusModel campusId,
  }) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ref.read(registerFormProvider.notifier).saveUniversityDetails(
            gradYear: gradYear,
            programId: programId,
            campusId: campusId,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedFormData = ref.watch(
      registerFormProvider.notifier
          .select((value) => value.savedUniversityDetails),
    );
    final gradYearController = useValueNotifier<int?>(
      savedFormData?.gradYear,
    );
    final programIdController = useValueNotifier<ProgramModel?>(
      savedFormData?.program,
    );
    final campusIdController = useValueNotifier<CampusModel?>(
      savedFormData?.campus,
    );

    return ScrollableColumn(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Insets.expand,

        // Graduation Year
        LabeledWidget(
          label: 'Graduation Year',
          useDarkerLabel: true,
          child: CustomDropdownField<int>.sheet(
            controller: gradYearController,
            selectedItemText: (item) => '$item',
            hintText: 'YYYY',
            itemsSheet: CustomDropdownSheet(
              bottomSheetTitle: 'Years',
              showSearch: true,
              searchFilterCondition: (searchTerm, item) {
                return '$item'.startsWith(searchTerm);
              },
              items: [for (var i = 2050; i >= 1950; i--) i],
              itemBuilder: (_, item) => DropdownSheetItem(
                label: '$item',
              ),
            ),
          ),
        ),

        Insets.gapH15,

        // Program Dropdown
        LabeledWidget(
          label: 'Programs',
          useDarkerLabel: true,
          child: CustomDropdownField<ProgramModel>.sheet(
            controller: programIdController,
            selectedItemText: (item) => item.program,
            hintText: 'Select a degree',
            itemsSheet: CustomDropdownSheet(
              items: ref.watch(programsProvider).getAllPrograms(),
              bottomSheetTitle: 'Programs',
              itemBuilder: (_, item) => DropdownSheetItem(
                label: item.program,
              ),
            ),
          ),
        ),

        Insets.gapH15,

        // Campus Dropdown
        LabeledWidget(
          label: 'Campuses',
          useDarkerLabel: true,
          child: CustomDropdownField<CampusModel>.sheet(
            controller: campusIdController,
            selectedItemText: (item) => item.campus,
            itemsSheet: CustomDropdownSheet(
              items: ref.watch(campusesProvider).getAllCampuses(),
              bottomSheetTitle: 'Campuses',
              itemBuilder: (_, item) => DropdownSheetItem(
                label: item.campus,
              ),
            ),
          ),
        ),

        Insets.expand,

        // Confirm Details Button
        CustomTextButton.gradient(
          width: double.infinity,
          onPressed: () => saveForm(
            ref,
            gradYear: gradYearController.value!,
            programId: programIdController.value!,
            campusId: campusIdController.value!,
          ),
          gradient: AppColors.buttonGradientPurple,
          child: Center(
            child: Text(
              'NEXT',
              style: AppTypography.secondary.body16.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),

        Insets.bottomInsetsLow,
      ],
    );
  }
}
