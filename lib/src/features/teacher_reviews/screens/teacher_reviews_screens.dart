import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/teacher_model.codegen.dart';

// Providers
import '../providers/teacher_reviews_provider.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Widgets
import '../widgets/reviews/teacher_detailed_ratings.dart';
import '../widgets/reviews/teacher_reviews_list.dart';

class TeacherReviewsScreen extends ConsumerWidget {
  final TeacherModel teacher;

  const TeacherReviewsScreen({
    Key? key,
    required this.teacher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref
        .watch(teacherReviewsProvider)
        .getAllTeacherReviews(teacher.teacherId);
    var learning = 0.0;
    var grading = 0.0;
    var attendance = 0.0;
    var difficulty = 0.0;
    for (var i = 0; i < reviews.length; i++) {
      learning = (learning * i + reviews[i].learning) / (i + 1);
      grading = (grading * i + reviews[i].grading) / (i + 1);
      attendance = (attendance * i + reviews[i].attendance) / (i + 1);
      difficulty = (difficulty * i + reviews[i].difficulty) / (i + 1);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          teacher.fullName,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        children: [
          Insets.gapH10,

          // Overalls
          TeacherDetailedRatings(
            averageRating: teacher.averageRating,
            totalReviews: teacher.totalReviews,
            learning: learning,
            grading: grading,
            attendance: attendance,
            difficulty: difficulty,
          ),

          // Reviews
          Expanded(
            child: TeacherReviewsList(reviews: reviews),
          ),
        ],
      ),
    );
  }
}
