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

  const GenderSelectionCards({
    Key? key,
    required this.controller,
  }) : super(key: key);

  void selectGender(Gender gender, {required bool isSelected}) {
    controller.value = isSelected ? null : gender;
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
                onTap: (_gender) {
                  selectGender(_gender, isSelected: gender == Gender.MALE);
                },
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
                onTap: (_gender) {
                  selectGender(_gender, isSelected: gender == Gender.FEMALE);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
