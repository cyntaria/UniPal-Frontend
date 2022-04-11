import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/hobbies_provider.dart';

// Models
import '../models/hobby_model.codegen.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

// Widgets
import '../../shared/widgets/custom_filter_chip.dart';

class HobbiesFilterChips extends ConsumerWidget {
  const HobbiesFilterChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hobbiesProv = ref.watch(hobbiesProvider);
    final allHobbies = hobbiesProv.getAllHobbies();
    final studentHobbies = hobbiesProv.getStudentHobbies();
    return Column(
      children: [
        // Warning
        Text(
          'Only select your top 3 hobbies.',
          style: AppTypography.primary.body14,
        ),

        Insets.gapH5,

        // Chips
        Wrap(
          spacing: 8,
          children: [
            for (var hobby in allHobbies)
              CustomFilterChip<HobbyModel>(
                value: hobby,
                label: Text(hobby.hobby),
                isSelected: studentHobbies.contains(hobby),
                onChanged: (isSelected, hobby) {
                  hobbiesProv.updateStudentHobbies(
                    isSelected: isSelected,
                    hobby: hobby,
                  );
                },
              ),
          ],
        ),
      ],
    );
  }
}
