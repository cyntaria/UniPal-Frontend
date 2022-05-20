import 'package:flutter/material.dart';

// Models
import '../../../profile/models/student_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/extensions/string_extension.dart';

// Widgets
import '../../../shared/widgets/custom_network_image.dart';

class StudentGridItem extends StatelessWidget {
  final StudentModel student;

  const StudentGridItem({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: Corners.rounded9,
          color: Colors.white,
          boxShadow: Shadows.elevated,
        ),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 13),
        child: Column(
          children: [
            // Circle Avatar
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(100, 233, 233, 233),
              ),
              padding: const EdgeInsets.all(2),
              child: CustomNetworkImage(
                height: 60,
                width: 60,
                shape: BoxShape.circle,
                imageUrl: student.profilePictureUrl,
              ),
            ),

            Insets.gapH5,

            // Full Name
            Text(
              '${student.firstName} ${student.lastName}',
              textAlign: TextAlign.center,
              style: AppTypography.primary.body14,
            ),

            Insets.expand,

            // Program
            Text(
              "${student.programId}'${'${student.graduationYear}'.substring(2)}",
              textAlign: TextAlign.center,
              style: AppTypography.primary.subtitle13.copyWith(
                color: AppColors.textLightGreyColor,
              ),
            ),

            Insets.gapH3,

            // Batch Type
            Text(
              '${student.studentType}'.capitalize,
              textAlign: TextAlign.center,
              style: AppTypography.primary.subtitle13,
            ),

            Insets.gapH3,

            // Current Status
            Text(
              '${student.currentStatusId}',
              textAlign: TextAlign.center,
              style: AppTypography.primary.subtitle13.copyWith(
                color: AppColors.textLightGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
