import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of roles that a user can be.
@JsonEnum()
enum Gender {
  @JsonValue('male') MALE,
  @JsonValue('female') FEMALE,
}

/// A utility with extensions for enum name and serialized value.
extension ExtGender on Gender{
  String get toJson => name.toLowerCase();
}
