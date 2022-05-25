// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';
import '../../profile/models/campus_model.codegen.dart';

part 'classroom_model.codegen.freezed.dart';
part 'classroom_model.codegen.g.dart';

@freezed
class ClassroomModel with _$ClassroomModel {
  const factory ClassroomModel({
    required int classroomId,
    required String classroom,
    required CampusModel campus,
  }) = _ClassroomModel;

  factory ClassroomModel.fromJson(JSON json) => _$ClassroomModelFromJson(json);
}
