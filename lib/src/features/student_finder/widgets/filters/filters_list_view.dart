import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Enums
import '../../../auth/enums/gender_enum.dart';

// Models
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

class FiltersListView extends HookConsumerWidget {
  final ScrollController scrollController;

  const FiltersListView({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programController = useTextEditingController(text: '');
    final campusController = useTextEditingController(text: '');
    final hobbyController = useTextEditingController(text: '');
    final interestController = useTextEditingController(text: '');
    final statusController = useTextEditingController(text: '');
    final batchController = useTextEditingController(text: '');
    final genderController = useValueNotifier<Gender>(Gender.MALE);

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
                onSelected: (program) {},
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
                onSelected: (campus) {},
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
            items: {for (var i = 2050; i >= 1950; i--) '$i': i},
            onSelected: (year) {},
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
                onSelected: (hobby) {},
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
                onSelected: (interest) {},
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
                onSelected: (studentStatus) {},
              ),
            );
          },
        ),

        Insets.gapH20,

        // Age Slider Filter
        LabeledWidget(
          label: 'Student Status',
          useDarkerLabel: true,
          child: CustomDropdownField<int>.animated(
            controller: statusController,
            enableSearch: true,
            hintText: 'Select a status',
            items: const {
              'Looking for friends': 1,
              'Looking for transport': 2,
              'Looking for lunch pal': 3,
              'Looking for relationships': 4,
              'Looking for jamming': 5,
              'Looking for basketball': 6,
              'Looking for futsal': 7,
              'Looking for cricket': 8,
              'Looking for cards': 9,
            },
            onSelected: (id) {},
          ),
        ),
      ],
    );
  }
}
