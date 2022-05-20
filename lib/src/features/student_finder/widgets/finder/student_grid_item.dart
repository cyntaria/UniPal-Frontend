import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../../profile/models/student_model.codegen.dart';

// Providers
import '../../../profile/providers/profile_provider.dart';
import '../../../profile/providers/programs_provider.dart';
import '../../../profile/providers/student_statuses_provider.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/extensions/string_extension.dart';

// Routing
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';

// Widgets
import '../../../shared/widgets/custom_network_image.dart';

class StudentGridItem extends ConsumerWidget {
  final StudentModel student;

  const StudentGridItem({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(profileScreenStudentProvider.state).state = student;
        AppRouter.pushNamed(Routes.ProfileScreenRoute);
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: Corners.rounded9,
          color: Colors.white,
          boxShadow: Shadows.elevated,
        ),
        padding: const EdgeInsets.all(15),
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
                height: 58,
                width: 58,
                shape: BoxShape.circle,
                imageUrl: student.profilePictureUrl,
              ),
            ),

            Insets.gapH10,

            // Full Name
            Text(
              '${student.firstName} ${student.lastName}',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.fade,
              style: AppTypography.primary.body14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            Insets.gapH5,

            // Program
            Consumer(
              builder: (_, ref, __) {
                final program = ref.watch(
                  programByIdProvider(student.programId),
                );
                return Text(
                  '${program.program} (${student.graduationYear})',
                  textAlign: TextAlign.center,
                  style: AppTypography.primary.body14.copyWith(
                    color: AppColors.textLightGreyColor,
                  ),
                );
              },
            ),

            Insets.gapH5,

            // Student Type
            Text(
              student.studentType.name.capitalize,
              textAlign: TextAlign.center,
              style: AppTypography.primary.body14,
            ),

            Insets.expand,

            // Current Status
            Consumer(
              builder: (_, ref, __) {
                final status = student.currentStatusId != null
                    ? ref.watch(
                        studentStatusByIdProvider(student.currentStatusId!),
                      )
                    : null;
                return Text(
                  status?.studentStatus ??
                      'Not looking for anything particular',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.primary.body14.copyWith(
                    color: AppColors.textLightGreyColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
