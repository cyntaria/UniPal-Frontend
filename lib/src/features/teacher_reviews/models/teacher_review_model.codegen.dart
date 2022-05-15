// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';
import '../../requests/models/request_student_model.codegen.dart';
import '../../timetables/models/subject_model.codegen.dart';

part 'teacher_review_model.codegen.freezed.dart';
part 'teacher_review_model.codegen.g.dart';

@freezed
class TeacherReviewModel with _$TeacherReviewModel {
  const factory TeacherReviewModel({
    required int reviewId,
    required int teacherId,
    required double learning,
    required double grading,
    required double attendance,
    required double difficulty,
    required double overallRating,
    required String comment,
    required DateTime reviewedAt,
    required SubjectModel subject,
    required RequestStudentModel reviewedBy,
  }) = _TeacherReviewModel;

  factory TeacherReviewModel.fromJson(JSON json) => _$TeacherReviewModelFromJson(json);
}
