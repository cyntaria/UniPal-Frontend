// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'sub_student_model.codegen.freezed.dart';
part 'sub_student_model.codegen.g.dart';

@freezed
class SubStudentModel with _$SubStudentModel {
  const factory SubStudentModel({
    required String erp,
    required String firstName,
    required String lastName,
    required String profilePictureUrl,
    required int programId,
    required int graduationYear,
  }) = _SubStudentModel;

  factory SubStudentModel.fromJson(JSON json) => _$SubStudentModelFromJson(json);
}
