import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of roles that a user can be.
@JsonEnum()
enum ResourceType {
  @JsonValue('image') IMAGE,
  @JsonValue('video') VIDEO,
}

/// A utility with extensions for enum name and serialized value.
extension ExtResourceType on ResourceType{
  String get toJson => name.toLowerCase();
}
