// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'reaction_type_model.codegen.freezed.dart';
part 'reaction_type_model.codegen.g.dart';

@freezed
class ReactionTypeModel with _$ReactionTypeModel {
  const factory ReactionTypeModel({
    required int reactionTypeId,
    required String reactionType,
  }) = _ReactionTypeModel;

  factory ReactionTypeModel.fromJson(JSON json) => _$ReactionTypeModelFromJson(json);
}
