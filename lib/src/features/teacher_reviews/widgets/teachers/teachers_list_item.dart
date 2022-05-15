import 'package:flutter/material.dart';

// Models
import '../../models/teacher_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';

// Routing
import '../../../../config/routes/app_router.dart';

// Screens
import '../../screens/teacher_reviews_screens.dart';

// Widgets
import '../../../shared/widgets/rating_stars.dart';

class TeachersListItem extends StatelessWidget {
  final TeacherModel teacher;

  const TeachersListItem({
    Key? key,
    required this.teacher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 14,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: Corners.rounded7,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE0E0E0),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Teacher Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Teacher Name
                Text(
                  teacher.fullName,
                  style: AppTypography.primary.body16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Rating Visual
                Row(
                  children: [
                    // Stars
                    RatingStars(
                      rating: teacher.averageRating,
                      starSize: IconSizes.med22,
                    ),

                    Insets.gapW5,

                    // No of Reviews
                    Text(
                      '(${teacher.totalReviews})',
                      style: AppTypography.primary.body14.copyWith(
                        color: AppColors.textGreyColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Average Rating And View More
          GestureDetector(
            onTap: () => AppRouter.push(
              TeacherReviewsScreen(teacher: teacher),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Average Rating
                Container(
                  decoration: BoxDecoration(
                    borderRadius: Corners.rounded50,
                    color:
                        const Color.fromARGB(248, 183, 0, 255).withOpacity(0.3),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 10,
                  ),
                  child: Center(
                    child: Text(
                      '${teacher.averageRating}',
                      style: AppTypography.primary.subtitle13.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),

                // View More
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Timetable Number
                      Text(
                        'View More',
                        style: AppTypography.primary.subtitle13.copyWith(
                          color: AppColors.lightPrimaryColor,
                          height: 1.4,
                        ),
                      ),

                      Insets.gapW5,

                      // Arrow
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
