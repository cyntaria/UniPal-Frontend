import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';

// Enums
import '../enums/post_privacy_enum.dart';

// Models
import '../../requests/models/sub_student_model.codegen.dart';
import 'post_resource_model.codegen.dart';

part 'post_model.codegen.freezed.dart';
part 'post_model.codegen.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    @JsonKey(toJson: AppUtils.toNull, includeIfNull: false) int? postId,
    required String body,
    required PostPrivacy privacy,
    @JsonKey(toJson: AppUtils.toNull, includeIfNull: false)
        required SubStudentModel author,
    required DateTime postedAt,
    @JsonKey(toJson: AppUtils.toNull, includeIfNull: false)
        List<PostReactionCountModel>? top3Reactions,
    required List<PostResourceModel>? resources,
  }) = _PostModel;

  factory PostModel.fromJson(JSON json) => _$PostModelFromJson(json);

  const PostModel._();

  static JSON toUpdateJson({
    String? body,
    String? authorErp,
    DateTime? postedAt,
    List<PostResourceModel>? resources,
    PostPrivacy? privacy,
  }) {
    return <String, Object?>{
      if (body != null) 'body': body,
      if (authorErp != null) 'author_erp': authorErp,
      if (postedAt != null) 'posted_at': AppUtils.dateTimeToJson(postedAt),
      if (privacy != null) 'privacy': privacy.toJson,
      if (resources != null)
        'resources': resources.map((e) => e.toJson()).toList(),
    };
  }
}

@freezed
class PostReactionCountModel with _$PostReactionCountModel {
  const factory PostReactionCountModel({
    required int reactionTypeId,
    required int reactionCount,
  }) = _PostReactionCountModel;

  factory PostReactionCountModel.fromJson(JSON json) =>
      _$PostReactionCountModelFromJson(json);
}
