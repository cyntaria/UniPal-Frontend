import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Enums
import '../enums/gender_enum.dart';

// Widgets
import '../../shared/widgets/custom_radio_button.dart';

class GenderSelectionCards extends StatefulWidget {
  const GenderSelectionCards({Key? key}) : super(key: key);

  @override
  _GenderSelectionCardsState createState() => _GenderSelectionCardsState();
}

class _GenderSelectionCardsState extends State<GenderSelectionCards> {
  late final ValueNotifier<Gender> genderNotifier;

  @override
  void initState() {
    super.initState();
    genderNotifier = ValueNotifier(Gender.male);
  }

  void selectGender(Gender gender) {
    genderNotifier.value = gender;
    // TODO(arafaysaleem): add provider code;
  }

  @override
  Widget build(BuildContext context) {
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
