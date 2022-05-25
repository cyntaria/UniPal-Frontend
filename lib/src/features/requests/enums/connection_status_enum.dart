import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of statuses that a connection
/// request can be in.
@JsonEnum()
enum ConnectionStatus {
  @JsonValue('request_pending')
  REQUEST_PENDING,
  @JsonValue('friends')
  FRIENDS;

  /// A utility with extensions for enum name and serialized value.
  String get toJson => name.toLowerCase();
}
