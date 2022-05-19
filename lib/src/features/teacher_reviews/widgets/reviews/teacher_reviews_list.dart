import 'package:flutter/material.dart';

// Models
import '../../../../helpers/constants/app_colors.dart';
import '../../models/teacher_review_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import 'teacher_review_list_item.dart';

class TeacherReviewsList extends StatelessWidget {
  final List<TeacherReviewModel> reviews;

  const TeacherReviewsList({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceColor,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: ListView.separated(
        itemCount: reviews.length,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, __) => Insets.gapH15,
        padding: EdgeInsets.zero,
        itemBuilder: (_, i) => TeacherReviewListItem(
          review: reviews[i],
        ),
      ),
    );
  }
}
