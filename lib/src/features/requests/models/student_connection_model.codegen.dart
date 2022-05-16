// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../enums/connection_status_enum.dart';
import '../../../helpers/typedefs.dart';
import 'sub_student_model.codegen.dart';

part 'student_connection_model.codegen.freezed.dart';
part 'student_connection_model.codegen.g.dart';

@freezed
class StudentConnectionModel with _$StudentConnectionModel {
  const factory StudentConnectionModel({
    required int studentConnectionModel,
    required ConnectionStatus connectionStatus,
    required DateTime sentAt,
    DateTime? acceptedAt,
    required SubStudentModel sender,
    required SubStudentModel receiver,
  }) = _StudentConnectionModel;

  factory StudentConnectionModel.fromJson(JSON json) => _$StudentConnectionModelFromJson(json);
}
