// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// Models
import 'class_model.codegen.dart';
import 'classroom_model.codegen.dart';
import 'subject_model.codegen.dart';
import 'timeslot_model.codegen.dart';
import '../../teacher_reviews/models/teacher_model.codegen.dart';

// Enums
import '../enums/day_enum.dart';

// Helpers
import '../../../helpers/typedefs.dart';
import '../../../helpers/constants/app_utils.dart';

part 'timetable_model.codegen.freezed.dart';
part 'timetable_model.codegen.g.dart';

List<String> _classesToErps(List<ClassModel> classes) {
  return classes.map((e) => e.classErp).toList();
}

@freezed
class TimetableModel with _$TimetableModel {
  const factory TimetableModel({
    @JsonKey(toJson: AppUtils.toNull, includeIfNull: false)
        int? timetableId,
    required String studentErp,
    required int termId,
    @JsonKey(
      fromJson: AppUtils.boolFromInt,
      toJson: AppUtils.toNull,
      includeIfNull: false,
    )
        required bool isActive,
    @JsonKey(toJson: _classesToErps)
        required List<ClassModel> classes,
  }) = _TimetableModel;

  factory TimetableModel.fromJson(JSON json) => _$TimetableModelFromJson(json);
}
