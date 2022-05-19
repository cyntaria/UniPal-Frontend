import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/hobbies_provider.dart';
import '../../providers/preferences_provider.dart';

// Models
import '../../models/hobby_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';

// Widgets
import '../../../shared/widgets/custom_filter_chip.dart';

class HobbiesFilterChips extends ConsumerWidget {
  const HobbiesFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allHobbies = ref.watch(hobbiesProvider).getAllHobbies();
    final selectedHobbies =
        ref.watch(prefsProvider.notifier).getSelectedHobbies();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Warning
        Text(
          'Only select your top 3 hobbies.',
          style: AppTypography.primary.body14.copyWith(
            color: Colors.black54,
          ),
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
                isSelected: selectedHobbies.contains(hobby.hobbyId),
                onChanged: (isSelected, hobby) {
                  return ref.read(prefsProvider.notifier).selectHobby(
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
