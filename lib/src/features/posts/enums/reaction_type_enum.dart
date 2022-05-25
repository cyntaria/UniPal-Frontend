// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/constants/app_assets.dart';
import '../../../helpers/constants/lottie_assets.dart';

/// A collection of reaction types supported by this app
@JsonEnum()
enum ReactionTypeEnum {
  @JsonValue('like')
  LIKE(
    assetPath: LottieAssets.likeLottie,
    logoPath: AppAssets.likeIcon,
  ),
  @JsonValue('love')
  LOVE(
    assetPath: LottieAssets.loveLottie,
    logoPath: AppAssets.loveIcon,
  ),
  @JsonValue('laugh')
  LAUGH(
    assetPath: LottieAssets.laughLottie,
    logoPath: AppAssets.laughIcon,
  ),
  @JsonValue('sad')
  SAD(
    assetPath: LottieAssets.sadLottie,
    logoPath: AppAssets.sadIcon,
  ),
  @JsonValue('wow')
  WOW(
    assetPath: LottieAssets.wowLottie,
    logoPath: AppAssets.wowIcon,
  ),
  @JsonValue('angry')
  ANGRY(
    assetPath: LottieAssets.angryLottie,
    logoPath: AppAssets.angryIcon,
  );

  final String assetPath;
  final String logoPath;

  const ReactionTypeEnum({
    required this.assetPath,
    required this.logoPath,
  });

  /// A utility with extensions for enum name and serialized value.
  String get toJson => name.toLowerCase();
}
