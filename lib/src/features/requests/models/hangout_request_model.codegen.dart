// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/constants/app_utils.dart';
import '../enums/connection_status_enum.dart';
import '../../../helpers/typedefs.dart';
import '../enums/hangout_request_status_enum.dart';
import 'sub_student_model.codegen.dart';

part 'hangout_request_model.codegen.freezed.dart';
part 'hangout_request_model.codegen.g.dart';

@freezed
class HangoutRequestModel with _$HangoutRequestModel {
  const factory HangoutRequestModel({
    required int hangoutRequestId,
    required HangoutRequestStatus requestStatus,
    required DateTime meetupAt,
    required String purpose,
    required int meetupSpotId,
    DateTime? acceptedAt,
    required SubStudentModel sender,
    required SubStudentModel receiver,
  }) = _HangoutRequestModel;

  factory HangoutRequestModel.fromJson(JSON json) =>
      _$HangoutRequestModelFromJson(json);

  static JSON toUpdateJson({
    DateTime? meetupAt,
    int? meetupSpotId,
    DateTime? acceptedAt,
    HangoutRequestStatus? requestStatus,
    String? purpose,
    String? senderErp,
    String? receiverErp,
  }) {
    final params = <String, Object?>{
      if (senderErp != null) 'sender_erp': senderErp,
      if (receiverErp != null) 'receiver_erp': receiverErp,
      if (purpose != null) 'purpose': purpose,
      if (meetupAt != null) 'meetup_at': AppUtils.dateTimeToJson(meetupAt),
      if (meetupSpotId != null) 'meetup_spot_id': meetupSpotId,
      if (acceptedAt != null) 'accepted_at': AppUtils.dateTimeToJson(acceptedAt),
      if (requestStatus != null) 'request_status': requestStatus.toJson,
    };
    return params;
  }
}
