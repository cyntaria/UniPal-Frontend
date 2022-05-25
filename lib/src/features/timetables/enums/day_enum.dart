import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of days that a class can be on.
@JsonEnum()
enum Day {
  @JsonValue('monday')
  MONDAY,
  @JsonValue('tuesday')
  TUESDAY,
  @JsonValue('wednesday')
  WEDNESDAY,
  @JsonValue('thursday')
  THURSDAY,
  @JsonValue('friday')
  FRIDAY,
  @JsonValue('saturday')
  SATURDAY,
  @JsonValue('sunday')
  SUNDAY;

  /// A utility with extensions for enum name and serialized value.
  String get toJson => name.toLowerCase();
}
