// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'teacher_model.codegen.freezed.dart';
part 'teacher_model.codegen.g.dart';

@freezed
class TeacherModel with _$TeacherModel {
  const factory TeacherModel({
    required int teacherId,
    required String fullName,
    required double averageRating,
    required int totalReviews,
  }) = _TeacherModel;

  factory TeacherModel.fromJson(JSON json) => _$TeacherModelFromJson(json);
}
