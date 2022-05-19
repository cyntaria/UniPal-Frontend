import 'package:flutter/material.dart';

// Providers
import '../../providers/timeslots_provider.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';

class TimeslotTitle extends StatelessWidget {
  final int slotNumber;
  final double height, width;

  const TimeslotTitle({
    super.key,
    required this.slotNumber,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final timeslot = timeslots.firstWhere(
      (t) => t['slot_number']! == slotNumber,
    );
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: AppColors.lightOutlineColor,
            width: 1.1,
          ),
        ),
      ),
      padding: const EdgeInsets.only(right: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Start Time
          Text(
            (timeslot['start_time']! as String).substring(0, 5),
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          Insets.gapH5,

          // End Time
          Text(
            (timeslot['end_time']! as String).substring(0, 5),
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textLightGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}
