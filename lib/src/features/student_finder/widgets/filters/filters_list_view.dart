import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Enums
import '../../../profile/enums/gender_enum.dart';

// Models
import '../../../profile/enums/student_type_enum.dart';
import '../../../profile/models/campus_model.codegen.dart';
import '../../../profile/models/hobby_model.codegen.dart';
import '../../../profile/models/interest_model.codegen.dart';
import '../../../profile/models/program_model.codegen.dart';
import '../../../profile/models/student_status_model.codegen.dart';

// Providers
import '../../../profile/providers/campuses_provider.dart';
import '../../../profile/providers/hobbies_provider.dart';
import '../../../profile/providers/interests_provider.dart';
import '../../../profile/providers/programs_provider.dart';
import '../../../profile/providers/student_statuses_provider.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../auth/widgets/gender_selection_cards.dart';
import '../../../shared/widgets/custom_dropdown_field.dart';
import '../../../shared/widgets/labeled_widget.dart';
import '../../providers/filter_providers.dart';

class FiltersListView extends HookConsumerWidget {
  final ScrollController scrollController;

  const FiltersListView({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genderController = useValueNotifier<Gender?>(null);
    final programController = useTextEditingController();
    final campusController = useTextEditingController();
    final hobbyController = useTextEditingController();
    final interestController = useTextEditingController();
    final statusController = useTextEditingController();
    final batchController = useTextEditingController();
    final studentTypeController = useTextEditingController();

    useEffect(() {
      genderController.value = ref.read(genderFilterProvider);
      programController.text = ref.read(programFilterProvider)?.program ?? '';
      campusController.text = ref.read(campusFilterProvider)?.campus ?? '';
      hobbyController.text = ref.read(hobbyFilterProvider)?.hobby ?? '';
      programController.text = ref.read(programFilterProvider)?.program ?? '';
      interestController.text =
          ref.read(interestFilterProvider)?.interest ?? '';
      statusController.text =
          ref.read(studentStatusFilterProvider)?.studentStatus ?? '';
      batchController.text = (ref.read(batchFilterProvider) ?? '').toString();
      studentTypeController.text =
          ref.read(studentTypeFilterProvider)?.name ?? '';
      return null;
    });

    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        // Gender Filter
        LabeledWidget(
          label: 'Gender',
          useDarkerLabel: true,
          child: GenderSelectionCards(
            controller: genderController,
            onSelect: (gender) {
              ref.read(genderFilterProvider.notifier).state = gender;
            },
          ),
        ),

        Insets.gapH20,

        // Program Dropdown Filter
        Consumer(
          builder: (context, ref, child) {
            final programs = ref.watch(programsProvider).getAllPrograms();
            return LabeledWidget(
              label: 'Program',
              useDarkerLabel: true,
              child: CustomDropdownField<ProgramModel>.animated(
                controller: programController,
                hintText: 'Select a program',
                items: {for (var e in programs) e.program: e},
                onSelected: (program) {
                  ref.read(programFilterProvider.notifier).state = program;
                },
              ),
            );
          },
        ),

        Insets.gapH20,

        // Campuses Dropdown Filter
        Consumer(
          builder: (context, ref, child) {
            final campuses = ref.watch(campusesProvider).getAllCampuses();
            return LabeledWidget(
              label: 'Campus',
              useDarkerLabel: true,
              child: CustomDropdownField<CampusModel>.animated(
                controller: campusController,
                hintText: 'Select a campus',
                items: {for (var e in campuses) e.campus: e},
                onSelected: (campus) {
                  ref.read(campusFilterProvider.notifier).state = campus;
                },
              ),
            );
          },
        ),

        Insets.gapH20,

        // Batch Dropdown Filter
        LabeledWidget(
          label: 'Batch Of',
          useDarkerLabel: true,
          child: CustomDropdownField<int>.animated(
            controller: batchController,
            enableSearch: true,
            hintText: 'Select a batch',
            items: {for (var i = 2026; i >= 1950; i--) '$i': i},
            onSelected: (year) {
              ref.read(batchFilterProvider.notifier).state = year;
            },
          ),
        ),

        Insets.gapH20,

        // Student Types Dropdown Filter
        LabeledWidget(
          label: 'Student Type',
          useDarkerLabel: true,
          child: CustomDropdownField<StudentType>.animated(
            controller: studentTypeController,
            enableSearch: true,
            hintText: 'Select a student type',
            items: {for (var e in StudentType.values) e.name: e},
            onSelected: (studentType) {
              ref.read(studentTypeFilterProvider.notifier).state = studentType;
            },
          ),
        ),

        Insets.gapH20,

        // Hobbies Dropdown Filter
        Consumer(
          builder: (context, ref, child) {
            final hobbies = ref.watch(hobbiesProvider).getAllHobbies();
            return LabeledWidget(
              label: 'Hobby',
              useDarkerLabel: true,
              child: CustomDropdownField<HobbyModel>.animated(
                controller: hobbyController,
                enableSearch: true,
                hintText: 'Select a hobby',
                items: {for (var e in hobbies) e.hobby: e},
                onSelected: (hobby) {
                  ref.read(hobbyFilterProvider.notifier).state = hobby;
                },
              ),
            );
          },
        ),

        Insets.gapH20,

        // Interests Dropdown Filter
        Consumer(
          builder: (context, ref, child) {
            final interests = ref.watch(interestsProvider).getAllInterests();
            return LabeledWidget(
              label: 'Interest',
              useDarkerLabel: true,
              child: CustomDropdownField<InterestModel>.animated(
                controller: interestController,
                enableSearch: true,
                hintText: 'Select an interest',
                items: {for (var e in interests) e.interest: e},
                onSelected: (interest) {
                  ref.read(interestFilterProvider.notifier).state = interest;
                },
              ),
            );
          },
        ),

        Insets.gapH20,

        // Student Statuses Dropdown Filter
        Consumer(
          builder: (context, ref, child) {
            final studentStatuses =
                ref.watch(studentStatusesProvider).getAllStudentStatuses();
            return LabeledWidget(
              label: 'Student Status',
              useDarkerLabel: true,
              child: CustomDropdownField<StudentStatusModel>.animated(
                controller: statusController,
                enableSearch: true,
                hintText: 'Select a status',
                items: {for (var e in studentStatuses) e.studentStatus: e},
                onSelected: (studentStatus) {
                  ref.read(studentStatusFilterProvider.notifier).state =
                      studentStatus;
                },
              ),
            );
          },
        ),

        Insets.gapH20,
      ],
    );
  }
}
