import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of roles that a user can be.
@JsonEnum()
enum StudentRole {
  @JsonValue('admin') ADMIN,
  @JsonValue('api_user') API_USER,
  @JsonValue('moderator') MODERATOR,
}

/// A utility with extensions for enum name and serialized value.
extension ExtStudentRole on StudentRole{
  String get toJson => name.toLowerCase();
}
