import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/typedefs.dart';

// Routing
import '../../../../config/routes/app_router.dart';

// Widgets
import '../timetable_viewer/timetable_view.dart';

class TimetableListItem extends StatelessWidget {
  final int timetableNumber;
  final JSON timetable;

  const TimetableListItem({
    Key? key,
    required this.timetableNumber,
    required this.timetable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final classDays = timetable.keys.toList();
    final numDays = classDays.length;
    final slots = (timetable[classDays[0]] as JSON).values.toList();
    final termId = slots[0]['term_id']! as int;
    return GestureDetector(
      onTap: () {
        AppRouter.push(
          TimetableView(
            timetable: timetable,
            title: 'Timetable No.$timetableNumber',
          ),
        );
      },
      child: Container(
        height: 180,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          borderRadius: Corners.rounded15,
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timetable Number
            Text(
              'Timetable No.$timetableNumber',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            Insets.gapH10,

            // Number Of Days
            Text(
              'No. Of Study Days: $numDays',
              style: const TextStyle(
                fontSize: 13,
              ),
            ),

            Insets.gapH3,

            // Term
            Text(
              'Term: $termId',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textLightGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
