// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';
import '../enums/resource_type_enum.dart';

part 'post_resource_model.codegen.freezed.dart';
part 'post_resource_model.codegen.g.dart';

@freezed
class PostResourceModel with _$PostResourceModel {
  const factory PostResourceModel({
    @JsonKey(toJson: AppUtils.toNull, includeIfNull: false) int? resourceId,
    required String resourceUrl,
    required ResourceType resourceType,
  }) = _PostResourceModel;

  factory PostResourceModel.fromJson(JSON json) =>
      _$PostResourceModelFromJson(json);
}
