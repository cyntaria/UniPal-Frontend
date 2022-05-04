import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/interests_provider.dart';
import '../../providers/preferences_provider.dart';

// Models
import '../../models/interest_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';

// Widgets
import '../../../shared/widgets/custom_filter_chip.dart';

class InterestsFilterChips extends ConsumerWidget {
  const InterestsFilterChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allInterests = ref.watch(interestsProvider).getAllInterests();
    final selectedInterests = ref.watch(prefsProvider).getSelectedInterests();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Warning
        Text(
          'Only select your top 3 interests.',
          style: AppTypography.primary.body14.copyWith(
            color: Colors.black54,
          ),
        ),

        Insets.gapH5,

        // Chips
        Wrap(
          spacing: 8,
          children: [
            for (var interest in allInterests)
              CustomFilterChip<InterestModel>(
                value: interest,
                label: Text(interest.interest),
                isSelected: selectedInterests.contains(interest.interestId),
                onChanged: (isSelected, interest) {
                  return ref.read(prefsProvider).selectInterest(
                        isSelected: isSelected,
                        interest: interest,
                      );
                },
              ),
          ],
        ),
      ],
    );
  }
}
