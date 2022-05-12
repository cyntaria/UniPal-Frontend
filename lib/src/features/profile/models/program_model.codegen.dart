// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../helpers/typedefs.dart';

part 'program_model.codegen.freezed.dart';
part 'program_model.codegen.g.dart';

@freezed
class ProgramModel with _$ProgramModel {
  const factory ProgramModel({
    required int programId,
    required String program,
  }) = _ProgramModel;

  factory ProgramModel.fromJson(JSON json) => _$ProgramModelFromJson(json);
}
