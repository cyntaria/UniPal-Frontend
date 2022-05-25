// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:time/time.dart';

import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';

part 'timeslot_model.codegen.freezed.dart';
part 'timeslot_model.codegen.g.dart';

@freezed
class TimeslotModel with _$TimeslotModel {
  const factory TimeslotModel({
    required int timeslotId,
    required int slotNumber,
    @JsonKey(fromJson: AppUtils.timeFromJson, toJson: AppUtils.toNull) required TimeOfDay startTime,
    @JsonKey(fromJson: AppUtils.timeFromJson, toJson: AppUtils.toNull) required TimeOfDay endTime,
  }) = _TimeslotModel;

  factory TimeslotModel.fromJson(JSON json) => _$TimeslotModelFromJson(json);
}
