import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of genders that a user can be.
@JsonEnum()
enum Gender {
  @JsonValue('male')
  MALE,
  @JsonValue('female')
  FEMALE;

  /// A utility with extensions for enum name and serialized value.
  String get toJson => name.toLowerCase();
}
