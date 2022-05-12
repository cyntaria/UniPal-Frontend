// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'request_student_model.codegen.freezed.dart';
part 'request_student_model.codegen.g.dart';

@freezed
class RequestStudentModel with _$RequestStudentModel {
  const factory RequestStudentModel({
    required String erp,
    required String firstName,
    required String lastName,
    required String profilePictureUrl,
    required int programId,
    required int graduationYear,
  }) = _RequestStudentModel;

  factory RequestStudentModel.fromJson(JSON json) => _$RequestStudentModelFromJson(json);
}
