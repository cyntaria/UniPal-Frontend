import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'detailed_ratings_model.codegen.freezed.dart';

@freezed
class DetailedRatingsModel with _$DetailedRatingsModel {
  const factory DetailedRatingsModel({
    required double learning,
    required double grading,
    required double attendance,
    required double difficulty,
  }) = _DetailedRatingsModel;
}
