// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// Models
import 'classroom_model.codegen.dart';
import 'subject_model.codegen.dart';
import 'timeslot_model.codegen.dart';
import '../../teacher_reviews/models/teacher_model.codegen.dart';

// Enums
import '../enums/day_enum.dart';

// Helpers
import '../../../helpers/typedefs.dart';

part 'class_model.codegen.freezed.dart';
part 'class_model.codegen.g.dart';

@freezed
class ClassModel with _$ClassModel {
  const factory ClassModel({
    required String classErp,
    required String semester,
    @JsonKey(includeIfNull: false) String? parentClassErp,
    required int termId,
    required Day day1,
    required Day day2,
    required ClassroomModel classroom,
    required SubjectModel subject,
    required TeacherModel teacher,
    required TimeslotModel timeslot1,
    required TimeslotModel timeslot2,
  }) = _ClassModel;

  factory ClassModel.fromJson(JSON json) => _$ClassModelFromJson(json);
}
