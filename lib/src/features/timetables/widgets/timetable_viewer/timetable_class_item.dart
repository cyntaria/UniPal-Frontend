import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/extensions/string_extension.dart';
import '../../../../helpers/typedefs.dart';

class TimetableClassItem extends StatelessWidget {
  final double height, width;
  final bool isBreakSlot;
  final JSON classModel;

  const TimetableClassItem({
    Key? key,
    required this.isBreakSlot,
    required this.height,
    required this.width,
    required this.classModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isBreakSlot) {
      return _BreakSlotItem(width: width);
    }
    final classErp = classModel['class_erp'] as String;
    final semester = classModel['semester'] as String;
    final subject = classModel['subject']['subject'] as String;
    final teacherName = classModel['teacher']['full_name'] as String;
    final teacherRating = classModel['teacher']['average_rating'] as String;
    final classroom = classModel['classroom']['classroom'] as String;
    final campus = classModel['classroom']['campus']['campus'] as String;
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: AppColors.lightOutlineColor,
            width: 1.1,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: Corners.rounded20,
          boxShadow: Shadows.small,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Class name
            Text(
              '$subject ($classErp)',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            Insets.gapH3,

            // Teacher Name and Rating
            Text(
              'By $teacherName (${teacherRating.substring(0, 3)})',
              style: const TextStyle(
                fontSize: 13,
              ),
            ),

            Insets.gapH3,

            // Classroom and Campus
            Text(
              'Room: $classroom, ${campus.capitalize}',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textLightGreyColor,
              ),
            ),

            Insets.gapH3,

            // Semester
            Text(
              'Semester: $semester',
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

class _BreakSlotItem extends StatelessWidget {
  final double width;

  const _BreakSlotItem({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: AppColors.lightOutlineColor,
            width: 1.1,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
      child: Container(
        height: 65,
        width: width,
        color: Colors.grey,
        child: const Center(
          child: Text(
            'Break',
            style: TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
