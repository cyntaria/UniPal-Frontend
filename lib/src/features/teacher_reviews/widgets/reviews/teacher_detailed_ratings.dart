import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';

// Widgets
import '../../../shared/widgets/labeled_widget.dart';
import '../../../shared/widgets/rating_stars.dart';

class TeacherDetailedRatings extends StatelessWidget {
  final double averageRating;
  final int totalReviews;
  final double learning;
  final double grading;
  final double attendance;
  final double difficulty;

  const TeacherDetailedRatings({
    Key? key,
    required this.averageRating,
    required this.totalReviews,
    required this.learning,
    required this.grading,
    required this.attendance,
    required this.difficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Overall Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$averageRating',
                style: AppTypography.primary.heading34.copyWith(
                  fontSize: 28,
                ),
              ),

              Insets.gapW10,

              // Stars
              RatingStars(
                rating: averageRating,
              ),

              Insets.gapW5,

              // Total Reviews
              Text(
                '($totalReviews)',
                style: AppTypography.primary.body16.copyWith(
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Insets.gapH10,

          const Divider(
            height: 0,
            color: AppColors.lightOutlineColor,
          ),

          Insets.gapH10,

          // Learning
          LabeledWidget(
            label: 'Learning',
            labelDirection: Axis.horizontal,
            expand: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RatingStars(
                  starSize: IconSizes.med22,
                  rating: learning,
                ),
                const SizedBox(width: 60),
                Text(
                  '$learning',
                  style: AppTypography.primary.body14,
                ),
              ],
            ),
          ),

          Insets.gapH10,

          // Grading
          LabeledWidget(
            label: 'Grading',
            labelDirection: Axis.horizontal,
            expand: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RatingStars(
                  starSize: IconSizes.med22,
                  rating: grading,
                ),
                const SizedBox(width: 60),
                Text(
                  '$grading',
                  style: AppTypography.primary.body14,
                ),
              ],
            ),
          ),

          Insets.gapH10,

          // Attendance
          LabeledWidget(
            label: 'Attendance',
            labelDirection: Axis.horizontal,
            expand: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RatingStars(
                  starSize: IconSizes.med22,
                  rating: attendance,
                ),
                const SizedBox(width: 60),
                Text(
                  '$attendance',
                  style: AppTypography.primary.body14,
                ),
              ],
            ),
          ),

          Insets.gapH10,

          // Difficulty
          LabeledWidget(
            label: 'Difficulty',
            labelDirection: Axis.horizontal,
            expand: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RatingStars(
                  starSize: IconSizes.med22,
                  rating: difficulty,
                ),
                const SizedBox(width: 60),
                Text(
                  '$difficulty',
                  style: AppTypography.primary.body14,
                ),
              ],
            ),
          ),

          Insets.gapH10,
        ],
      ),
    );
  }
}
