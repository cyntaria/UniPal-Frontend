// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'student_status_model.codegen.freezed.dart';
part 'student_status_model.codegen.g.dart';

@freezed
class StudentStatusModel with _$StudentStatusModel {
  const factory StudentStatusModel({
    required int studentStatusId,
    required String studentStatus,
  }) = _StudentStatusModel;

  factory StudentStatusModel.fromJson(JSON json) => _$StudentStatusModelFromJson(json);
}
