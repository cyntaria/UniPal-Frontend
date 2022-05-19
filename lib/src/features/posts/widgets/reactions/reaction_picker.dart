import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_assets.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/lottie_assets.dart';

// Widgets
import 'floating_reaction_model.dart';
import 'floating_reactions_widget.dart';

class ReactionPicker extends StatelessWidget {
  const ReactionPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: FloatingReactionsWidget(
        onSelected: (f) {
          debugPrint('Selected: ${f.label}');
        },
        onUnSelect: (f) {
          debugPrint('Unselected: ${f?.label}');
        },
        defaultReaction: const FloatingReactionModel<String>(
          value: 'No Reaction',
          label: 'Like',
          assetPath: LottieAssets.likeLottie,
          logoPath: AppAssets.likeOutlinedIcon,
          color: AppColors.textLightGreyColor,
        ),
        shortTapSelectIndex: 0,
        reactions: const [
          FloatingReactionModel<String>(
            value: 'Like',
            label: 'Like',
            assetPath: LottieAssets.likeLottie,
            logoPath: AppAssets.likeIcon,
            color: Color(0xff3b5998),
          ),
          FloatingReactionModel<String>(
            value: 'Love',
            label: 'Love',
            assetPath: LottieAssets.loveLottie,
            logoPath: AppAssets.loveIcon,
            color: Color(0xffED5167),
          ),
          FloatingReactionModel<String>(
            value: 'Laugh',
            label: 'Laugh',
            assetPath: LottieAssets.laughLottie,
            logoPath: AppAssets.laughIcon,
            color: Color(0xffFFD96A),
          ),
          FloatingReactionModel<String>(
            value: 'Wow',
            label: 'Wow',
            assetPath: LottieAssets.wowLottie,
            logoPath: AppAssets.wowIcon,
            color: Color(0xffFFD96A),
          ),
          FloatingReactionModel<String>(
            value: 'Sad',
            label: 'Sad',
            assetPath: LottieAssets.sadLottie,
            logoPath: AppAssets.sadIcon,
            color: Color(0xffFFD96A),
          ),
          FloatingReactionModel<String>(
            value: 'Angry',
            label: 'Angry',
            assetPath: LottieAssets.angryLottie,
            logoPath: AppAssets.angryIcon,
            color: Color(0xffF6876B),
          ),
        ],
      ),
    );
  }
}
