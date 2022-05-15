// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'subject_model.codegen.freezed.dart';
part 'subject_model.codegen.g.dart';

@freezed
class SubjectModel with _$SubjectModel {
  const factory SubjectModel({
    required String subjectCode,
    required String subject,
  }) = _SubjectModel;

  factory SubjectModel.fromJson(JSON json) => _$SubjectModelFromJson(json);
}
