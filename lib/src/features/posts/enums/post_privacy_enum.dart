import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of privacies that a post can have.
@JsonEnum()
enum PostPrivacy {
  @JsonValue('public')
  PUBLIC,
  @JsonValue('private')
  PRIVATE,
  @JsonValue('limited')
  LIMITED;

  /// A utility with extensions for enum name and serialized value.
  String get toJson => name.toLowerCase();
}
