// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';
import 'request_student_model.codegen.dart';

part 'student_connection_model.codegen.freezed.dart';
part 'student_connection_model.codegen.g.dart';

@freezed
class StudentConnectionModel with _$StudentConnectionModel {
  const factory StudentConnectionModel({
    required int studentConnectionModel,
    required String connectionStatus,
    required DateTime sentAt,
    DateTime? acceptedAt,
    required RequestStudentModel sender,
    required RequestStudentModel receiver,
  }) = _StudentConnectionModel;

  factory StudentConnectionModel.fromJson(JSON json) => _$StudentConnectionModelFromJson(json);
}
