import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of resource types a post can have.
@JsonEnum()
enum ResourceType {
  @JsonValue('image')
  IMAGE,
  @JsonValue('video')
  VIDEO;

  /// A utility with extensions for enum name and serialized value.
  String get toJson => name.toLowerCase();
}
