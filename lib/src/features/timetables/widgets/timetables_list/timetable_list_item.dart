import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/typedefs.dart';

// Widgets
import '../../../shared/widgets/custom_text_button.dart';

class TimetableListItem extends StatelessWidget {
  final String title;
  final JSON timetable;
  final VoidCallback onTap;

  const TimetableListItem({
    super.key,
    required this.title,
    required this.timetable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final classDays = timetable.keys.toList();
    final numDays = classDays.length;
    final slots = (timetable[classDays[0]] as JSON).values.toList();
    final termId = slots[0]['term_id']! as int;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 170,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: const BoxDecoration(
          borderRadius: Corners.rounded15,
          color: Colors.white,
          boxShadow: Shadows.small,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Timetable Number
                Text(
                  title,
                  style: AppTypography.primary.title18.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Arrow
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 25,
                )
              ],
            ),

            Insets.gapH15,

            // Number Of Days
            Text(
              'No. Of Study Days: $numDays',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),

            Insets.gapH5,

            // Term
            Text(
              'Term: Fall 2022 ($termId)',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textLightGreyColor,
              ),
            ),

            Insets.expand,

            // Set Active Button
            // CustomTextButton.gradient(
            //   height: 35,
            //   onPressed: () {},
            //   gradient: AppColors.buttonGradientPurple,
            //   child: Center(
            //     child: Text(
            //       'Set Active',
            //       style: AppTypography.secondary.subtitle13.copyWith(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
