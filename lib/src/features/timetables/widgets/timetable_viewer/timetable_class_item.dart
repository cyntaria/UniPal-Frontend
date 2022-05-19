import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_utils.dart';
import '../../../../helpers/extensions/string_extension.dart';
import '../../../../helpers/typedefs.dart';

class TimetableClassItem extends StatelessWidget {
  final double height, width;
  final bool isBreakSlot;
  final JSON? classModel;

  const TimetableClassItem({
    super.key,
    required this.isBreakSlot,
    required this.height,
    required this.width,
    required this.classModel,
  });

  @override
  Widget build(BuildContext context) {
    if (isBreakSlot) {
      return _BreakSlotItem(width: width);
    }
    if (classModel == null) {
      return SizedBox(
        height: height,
        width: width,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: AppColors.lightOutlineColor,
                width: 1.1,
              ),
            ),
          ),
        ),
      );
    }
    final classErp = classModel!['class_erp'] as String;
    final semester = classModel!['semester'] as String;
    final subject = classModel!['subject']['subject'] as String;
    final teacherName = classModel!['teacher']['full_name'] as String;
    final teacherRating = classModel!['teacher']['average_rating'] as String;
    final classroom = classModel!['classroom']['classroom'] as String;
    final campus = classModel!['classroom']['campus']['campus'] as String;
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
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: Corners.rounded20,
          boxShadow: Shadows.small,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Class name
            _ClassHeader(
              subject: subject,
              classErp: classErp,
            ),

            // Class details
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 11, 15, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Teacher Name and Rating
                  Text(
                    'By $teacherName (${teacherRating.substring(0, 3)})',
                    style: const TextStyle(
                      fontSize: 14,
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

                  const SizedBox(height: 8),

                  // Classroom and Campus
                  Row(
                    children: [
                      // Icon
                      const Icon(
                        Icons.location_pin,
                        size: 16,
                        color: AppColors.greyOutlineColor,
                      ),

                      Insets.gapW5,

                      // Room
                      Text(
                        '$classroom, ${campus.capitalize} Campus',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textLightGreyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClassHeader extends StatelessWidget {
  const _ClassHeader({
    required this.subject,
    required this.classErp,
  });

  final String subject;
  final String classErp;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: AppUtils.getRandomColor(int.parse(classErp)),
      ),
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 10),
      child: Row(
        children: [
          // Name
          LimitedBox(
            maxWidth: 114,
            child: Text(
              subject,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            ),
          ),

          Insets.gapW5,

          // Erp
          Text(
            '($classErp)',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _BreakSlotItem extends StatelessWidget {
  final double width;

  const _BreakSlotItem({
    required this.width,
  });

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
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
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
