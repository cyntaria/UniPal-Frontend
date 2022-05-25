// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';

part 'post_reaction_model.codegen.freezed.dart';
part 'post_reaction_model.codegen.g.dart';

@freezed
class PostReactionModel with _$PostReactionModel {
  const factory PostReactionModel({
    @JsonKey(toJson: AppUtils.toNull, includeIfNull: false) int? postId,
    required int reactionTypeId,
    required String studentErp,
    @JsonKey(toJson: AppUtils.dateToJson) required DateTime reactedAt,
  }) = _PostReactionModel;

  factory PostReactionModel.fromJson(JSON json) =>
      _$PostReactionModelFromJson(json);
}
