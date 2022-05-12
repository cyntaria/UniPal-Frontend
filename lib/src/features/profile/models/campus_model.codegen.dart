// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'campus_model.codegen.freezed.dart';
part 'campus_model.codegen.g.dart';

@freezed
class CampusModel with _$CampusModel {
  const factory CampusModel({
    required int campusId,
    required String campus,
    required String locationUrl,
  }) = _CampusModel;

  factory CampusModel.fromJson(JSON json) => _$CampusModelFromJson(json);
}
