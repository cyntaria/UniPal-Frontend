// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'activity_status_model.codegen.freezed.dart';
part 'activity_status_model.codegen.g.dart';

@freezed
class ActivityStatusModel with _$ActivityStatusModel {
  const factory ActivityStatusModel({
    required int activityStatusId,
    required String activityStatus,
  }) = _ActivityStatusModel;

  factory ActivityStatusModel.fromJson(JSON json) => _$ActivityStatusModelFromJson(json);
}
