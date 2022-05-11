import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';

// Enums
import '../../auth/enums/gender_enum.dart';
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
    @JsonKey(includeIfNull: false) Set<int>? hobbies,
    @JsonKey(includeIfNull: false) Set<int>? interests,
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
}
