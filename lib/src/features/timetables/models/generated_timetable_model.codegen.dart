// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// Models
import 'class_model.codegen.dart';

// Helpers
import '../../../helpers/typedefs.dart';

part 'generated_timetable_model.codegen.freezed.dart';
part 'generated_timetable_model.codegen.g.dart';

typedef GeneratedTimetableJSON = Map<String, Map<String, ClassModel>>;

@Freezed(fromJson: false, toJson: true)
class GeneratedTimetableModel with _$GeneratedTimetableModel {
  const factory GeneratedTimetableModel({
    required int noOfSubjects,
    required List<ClassModel> classes,
  }) = _GeneratedTimetableModel;

  static GeneratedTimetableJSON parseGeneratedJSON(JSON json) {
    Map<String, ClassModel> slotMapper(JSON json) {
      return json.map<String, ClassModel>((slot, Object? classModel) {
        return MapEntry(slot, ClassModel.fromJson(json));
      });
    }

    return json.map(
      (weekday, Object? slot) => MapEntry(weekday, slotMapper(slot! as JSON)),
    );
  }
}
