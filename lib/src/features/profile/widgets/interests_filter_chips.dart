import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/interests_provider.dart';

// Models
import '../models/interest_model.codegen.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

// Widgets
import '../../shared/widgets/custom_filter_chip.dart';

class InterestsFilterChips extends ConsumerWidget {
  const InterestsFilterChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interestsProv = ref.watch(interestsProvider);
    final allInterests = interestsProv.getAllInterests();
    final studentInterests = interestsProv.getStudentInterests();
    return Column(
      children: [
        // Warning
        Text(
          'Only select your top 3 interests.',
          style: AppTypography.primary.body14,
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
                isSelected: studentInterests.contains(interest),
                onChanged: (isSelected, interest) {
                  interestsProv.updateStudentInterests(
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
