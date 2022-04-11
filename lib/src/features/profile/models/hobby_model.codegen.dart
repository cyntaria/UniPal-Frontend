// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'hobby_model.codegen.freezed.dart';
part 'hobby_model.codegen.g.dart';

@freezed
class HobbyModel with _$HobbyModel {
  const factory HobbyModel({
    required int hobbyId,
    required String hobby,
  }) = _HobbyModel;

  factory HobbyModel.fromJson(JSON json) => _$HobbyModelFromJson(json);
}
