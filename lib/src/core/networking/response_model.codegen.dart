// ignore_for_file: unused_element

import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../helpers/constants/app_utils.dart';
import '../../helpers/typedefs.dart';

part 'response_model.codegen.freezed.dart';
part 'response_model.codegen.g.dart';

@freezed
class ResponseModel with _$ResponseModel {
  const factory ResponseModel({
    required _ResponseHeadersModel headers,
    required JSON body,
  }) = _ResponseModel;

  factory ResponseModel.fromJson(JSON json) => _$ResponseModelFromJson(json);
}

@freezed
class _ResponseHeadersModel with _$_ResponseHeadersModel {
  const factory _ResponseHeadersModel({
    @JsonKey(fromJson: AppUtils.boolFromInt, toJson: AppUtils.boolToInt)
        required bool error,
    required String message,
    String? code,
  }) = __ResponseHeadersModel;

  factory _ResponseHeadersModel.fromJson(JSON json) =>
      _$_ResponseHeadersModelFromJson(json);
}
