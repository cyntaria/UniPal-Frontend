import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_assets.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';

class PostReactionsCount extends StatelessWidget {
  const PostReactionsCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rcns = [AppAssets.laughIcon, AppAssets.likeIcon, AppAssets.loveIcon];
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const VerticalDivider(
            color: AppColors.greyOutlineColor,
            width: 0,
          ),

          const SizedBox(width: 35),

          // Top 3 Reactions
          Row(
            children: [
              for (var c in rcns)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      // Reaction
                      Image.asset(
                        c,
                        width: 20,
                        height: 20,
                      ),

                      Insets.gapW5,

                      // Count
                      Text(
                        '${20 + c.length}',
                        style: const TextStyle(
                          color: AppColors.textLightGreyColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const SizedBox(width: 35),
        ],
      ),
    );
  }
}
