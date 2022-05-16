import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';

// Enums
import '../enums/gender_enum.dart';
import '../enums/student_role_enum.dart';

part 'student_model.codegen.freezed.dart';
part 'student_model.codegen.g.dart';

@freezed
class StudentModel with _$StudentModel {
  const factory StudentModel({
    required String erp,
    required String firstName,
    required String lastName,
    required Gender gender,
    required String contact,
    @JsonKey(includeIfNull: false) String? email,
    @JsonKey(toJson: AppUtils.dateToJson) required DateTime birthday,
    required String profilePictureUrl,
    required int graduationYear,
    required String uniEmail,
    @JsonKey(includeIfNull: false, fromJson: AppUtils.removeNulls)
        List<int>? hobbies,
    @JsonKey(includeIfNull: false, fromJson: AppUtils.removeNulls)
        List<int>? interests,
    required int programId,
    required int campusId,
    @JsonKey(includeIfNull: false) String? favouriteCampusHangoutSpot,
    @JsonKey(includeIfNull: false) String? favouriteCampusActivity,
    @JsonKey(includeIfNull: false) StudentRole? role,
    @JsonKey(name: 'current_status', includeIfNull: false) int? currentStatusId,
    @JsonKey(fromJson: AppUtils.boolFromInt, toJson: AppUtils.boolToInt)
        required bool isActive,
  }) = _StudentModel;

  factory StudentModel.fromJson(JSON json) => _$StudentModelFromJson(json);

  const StudentModel._();

  static JSON toUpdateJson({
    String? erp,
    String? firstName,
    String? lastName,
    Gender? gender,
    String? contact,
    String? email,
    DateTime? birthday,
    String? profilePictureUrl,
    int? graduationYear,
    String? uniEmail,
    int? hobby1,
    int? hobby2,
    int? hobby3,
    int? interest1,
    int? interest2,
    int? interest3,
    int? programId,
    int? campusId,
    String? favouriteCampusHangoutSpot,
    String? favouriteCampusActivity,
    StudentRole? role,
    int? currentStatusId,
    bool? isActive,
  }) {
    return <String, Object?>{
      if (erp != null) 'erp': erp,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (gender != null) 'gender': gender,
      if (contact != null) 'contact': contact,
      if (email != null) 'email': email,
      if (birthday != null) 'birthday': birthday,
      if (profilePictureUrl != null) 'profile_picture_url': profilePictureUrl,
      if (graduationYear != null) 'graduation_year': graduationYear,
      if (uniEmail != null) 'uni_email': uniEmail,
      if (hobby1 != null) 'hobby_1': hobby1,
      if (hobby2 != null) 'hobby_2': hobby2,
      if (hobby3 != null) 'hobby_3': hobby3,
      if (interest1 != null) 'interest_1': interest1,
      if (interest2 != null) 'interest_2': interest2,
      if (interest3 != null) 'interest_3': interest3,
      if (programId != null) 'program_id': programId,
      if (campusId != null) 'campus_id': campusId,
      if (favouriteCampusHangoutSpot != null)
        'favourite_campus_hangout_spot': favouriteCampusHangoutSpot,
      if (favouriteCampusActivity != null)
        'favourite_campus_activity': favouriteCampusActivity,
      if (role != null) 'role': role,
      if (currentStatusId != null) 'current_status': currentStatusId,
      if (isActive != null) 'is_active': isActive,
    };
  }
}
