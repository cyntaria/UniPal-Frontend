// ignore_for_file: use_setters_to_change_properties
import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Enums
import '../../profile/enums/gender_enum.dart';

// Widgets
import '../../shared/widgets/custom_radio_button.dart';

class GenderSelectionCards extends StatelessWidget {
  final ValueNotifier<Gender?> controller;
  final void Function(Gender?)? onSelect;

  const GenderSelectionCards({
    super.key,
    required this.controller,
    this.onSelect,
  });

  void selectGender(Gender gender) {
    controller.value = controller.value == gender ? null : gender;
    onSelect?.call(controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Gender?>(
      valueListenable: controller,
      builder: (_, gender, __) {
        return Row(
          children: [
            // Male Radio
            Expanded(
              child: CustomRadioButton<Gender>(
                value: Gender.MALE,
                isSelected: gender == Gender.MALE,
                icon: Icons.male_rounded,
                label: 'Male',
                onTap: selectGender,
              ),
            ),

            Insets.gapW10,

            // Female Radio
            Expanded(
              child: CustomRadioButton<Gender>(
                value: Gender.FEMALE,
                isSelected: gender == Gender.FEMALE,
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
