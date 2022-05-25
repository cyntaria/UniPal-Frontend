// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'term_model.codegen.freezed.dart';
part 'term_model.codegen.g.dart';

@freezed
class TermModel with _$TermModel {
  const factory TermModel({
    required int termId,
    required String term,
  }) = _TermModel;

  factory TermModel.fromJson(JSON json) => _$TermModelFromJson(json);
}
