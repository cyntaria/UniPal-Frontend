import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of roles that a user can be.
@JsonEnum()
enum HangoutRequestStatus {
  @JsonValue('request_pending') REQUEST_PENDING,
  @JsonValue('accepted') ACCEPTED,
  @JsonValue('rejected') REJECTED,
}

/// A utility with extensions for enum name and serialized value.
extension ExtHangoutRequestStatus on HangoutRequestStatus{
  String get toJson => name.toLowerCase();
}
