import 'package:flutter/material.dart';

// Models
import '../../models/teacher_review_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/extensions/datetime_extension.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../shared/widgets/labeled_widget.dart';
import '../../../shared/widgets/rating_stars.dart';

class TeacherReviewListItem extends StatelessWidget {
  final TeacherReviewModel review;

  const TeacherReviewListItem({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Corners.rounded20,
        border: Border.all(
          width: 1.1,
          color: AppColors.lightOutlineColor,
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Row
          SizedBox(
            height: 42,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author Avatar
                CircleAvatar(
                  radius: 21,
                  backgroundImage: NetworkImage(
                    review.reviewedBy.profilePictureUrl,
                  ),
                ),

                Insets.gapW10,

                // Author & Post Detals
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Author Name
                      Text(
                        '${review.reviewedBy.firstName} ${review.reviewedBy.lastName}',
                        style: AppTypography.primary.body14.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Reviewed Datetime
                      Text(
                        review.reviewedAt.toTimeAgoLabel(),
                        style: AppTypography.primary.subtitle13.copyWith(
                          color: AppColors.textLightGreyColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Overall Rating
                Container(
                  height: 22,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: Corners.rounded50,
                    color: const Color.fromARGB(
                      248,
                      183,
                      0,
                      255,
                    ).withOpacity(0.3),
                  ),
                  child: Center(
                    child: Text(
                      '${review.overallRating}',
                      style: AppTypography.primary.subtitle13.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),

                Insets.gapW10,

                // More Options Icon
                const Icon(
                  Icons.more_horiz_rounded,
                  color: AppColors.greyOutlineColor,
                ),
              ],
            ),
          ),

          Insets.gapH15,

          // Subject Details
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.5),
              color: AppColors.textLightGreyColor.withOpacity(0.2),
            ),
            child: Text(
              'Studied ${review.subject.subject}',
              style: AppTypography.primary.label12.copyWith(
                color: const Color.fromARGB(255, 158, 167, 172),
              ),
            ),
          ),

          Insets.gapH10,

          // Body Text
          Text(
            review.comment,
            style: AppTypography.primary.body14.copyWith(
              color: Colors.black54,
            ),
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
                  starSize: IconSizes.sm19,
                  rating: review.learning,
                ),
                const SizedBox(width: 60),
                Text(
                  '${review.learning}',
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
                  starSize: IconSizes.sm19,
                  rating: review.grading,
                ),
                const SizedBox(width: 60),
                Text(
                  '${review.grading}',
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
                  starSize: IconSizes.sm19,
                  rating: review.attendance,
                ),
                const SizedBox(width: 60),
                Text(
                  '${review.attendance}',
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
                  starSize: IconSizes.sm19,
                  rating: review.difficulty,
                ),
                const SizedBox(width: 60),
                Text(
                  '${review.difficulty}',
                  style: AppTypography.primary.body14,
                ),
              ],
            ),
          ),

          Insets.gapH5,
        ],
      ),
    );
  }
}
