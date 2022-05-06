import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../../profile/models/hobby_model.codegen.dart';
import '../../../profile/models/interest_model.codegen.dart';

// Providers
import '../../../profile/providers/campus_provider.dart';
import '../../../profile/providers/hobbies_provider.dart';
import '../../../profile/providers/interests_provider.dart';
import '../../../profile/providers/program_provider.dart';

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
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        // Gender Filter
        const LabeledWidget(
          label: 'Gender',
          useDarkerLabel: true,
          child: GenderSelectionCards(),
        ),

        Insets.gapH20,

        // Program Dropdown Filter
        LabeledWidget(
          label: 'Program',
          useDarkerLabel: true,
          child: CustomDropdownField<int>.animated(
            controller: programController,
            hintText: 'Select a program',
            items: programs.map((key, value) => MapEntry(value, key)),
            onSelected: (id) {},
          ),
        ),

        Insets.gapH20,

        // Campuses Dropdown Filter
        LabeledWidget(
          label: 'Campus',
          useDarkerLabel: true,
          child: CustomDropdownField<int>.animated(
            controller: campusController,
            hintText: 'Select a campus',
            items: campuses.map((key, value) => MapEntry(value, key)),
            onSelected: (id) {},
          ),
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
            items: const {
              '2025': 2025,
              '2024': 2024,
              '2023': 2023,
              '2022': 2022,
              '2021': 2021,
              '2020': 2020,
            },
            onSelected: (id) {},
          ),
        ),

        Insets.gapH20,

        // Hobbies Dropdown Filter
        LabeledWidget(
          label: 'Hobby',
          useDarkerLabel: true,
          child: CustomDropdownField<HobbyModel>.animated(
            controller: hobbyController,
            enableSearch: true,
            hintText: 'Select a hobby',
            items: ref
                .watch(
                  hobbiesProvider.select((value) => value.getHobbiesMap()),
                )
                .map((k, v) => MapEntry(v.hobby, v)),
            onSelected: (id) {},
          ),
        ),

        Insets.gapH20,

        // Interests Dropdown Filter
        LabeledWidget(
          label: 'Interest',
          useDarkerLabel: true,
          child: CustomDropdownField<InterestModel>.animated(
            controller: interestController,
            enableSearch: true,
            hintText: 'Select an interest',
            items: ref
                .watch(
                  interestsProvider.select((value) => value.getInterestsMap()),
                )
                .map((k, v) => MapEntry(v.interest, v)),
            onSelected: (id) {},
          ),
        ),

        Insets.gapH20,

        // Student Statuses Dropdown Filter
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
