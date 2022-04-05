import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_state.codegen.freezed.dart';

@freezed
class RegistrationState with _$RegistrationState {

  const factory RegistrationState.personal() = PERSONAL;

  const factory RegistrationState.university() = UNIVERSITY;

  const factory RegistrationState.password() = PASSWORD;
}
