import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/auth_provider.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Enums
import '../enums/gender_enum.dart';

// Widgets
import '../../shared/widgets/custom_radio_button.dart';

class GenderSelectionCards extends HookConsumerWidget {
  const GenderSelectionCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genderNotifier = useValueNotifier(Gender.male);

    void selectGender(Gender gender) {
      genderNotifier.value = gender;
      ref.read(authProvider.notifier).saveGender(gender.name);
    }

    return ValueListenableBuilder<Gender>(
      valueListenable: genderNotifier,
      builder: (_, gender, __) {
        return Row(
          children: [
            // Male Radio
            Expanded(
              child: CustomRadioButton<Gender>(
                value: Gender.male,
                isSelected: gender == Gender.male,
                icon: Icons.male_rounded,
                label: 'Male',
                onTap: selectGender,
              ),
            ),

            Insets.gapW10,

            // Female Radio
            Expanded(
              child: CustomRadioButton<Gender>(
                value: Gender.female,
                isSelected: gender == Gender.female,
                icon: Icons.female_rounded,
                label: 'Female',
                onTap: selectGender,
              ),
            ),
          ],
        );
      },
    );
  }
}
