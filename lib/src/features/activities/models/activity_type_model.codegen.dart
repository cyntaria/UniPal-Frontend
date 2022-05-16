// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'activity_type_model.codegen.freezed.dart';
part 'activity_type_model.codegen.g.dart';

@freezed
class ActivityTypeModel with _$ActivityTypeModel {
  const factory ActivityTypeModel({
    required int activityTypeId,
    required String activityType,
  }) = _ActivityTypeModel;

  factory ActivityTypeModel.fromJson(JSON json) => _$ActivityTypeModelFromJson(json);
}
