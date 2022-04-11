// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'interest_model.codegen.freezed.dart';
part 'interest_model.codegen.g.dart';

@freezed
class InterestModel with _$InterestModel {
  const factory InterestModel({
    required int interestId,
    required String interest,
  }) = _InterestModel;

  factory InterestModel.fromJson(JSON json) => _$InterestModelFromJson(json);
}
