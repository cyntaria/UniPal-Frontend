import 'package:flutter/material.dart';

// Models
import '../../models/teacher_review_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import 'teacher_review_list_item.dart';

class TeacherReviewsList extends StatelessWidget {
  final List<TeacherReviewModel> reviews;

  const TeacherReviewsList({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: reviews.length,
      separatorBuilder: (_, __) => Insets.gapH15,
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      itemBuilder: (_, i) => TeacherReviewListItem(
        review: reviews[i],
      ),
    );
  }
}
