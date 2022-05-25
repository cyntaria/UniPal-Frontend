import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../models/post_model.codegen.dart';

// Providers
import '../../providers/reaction_types_provider.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';

class PostReactionsCount extends StatelessWidget {
  final List<PostReactionCountModel>? top3reactions;

  const PostReactionsCount({
    super.key,
    required this.top3reactions,
  });

  @override
  Widget build(BuildContext context) {
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

          SizedBox(
            width: top3reactions == null ? 73 : 35,
          ),

          // Top 3 Reactions
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (top3reactions != null)
                for (var r in top3reactions!)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        // Reaction
                        Consumer(
                          builder: (context, ref, child) {
                            final reactionType = ref.watch(
                              reactionTypeByIdProvider(r.reactionTypeId),
                            );
                            return Image.asset(
                              reactionType.reactionType.logoPath,
                              width: 20,
                              height: 20,
                            );
                          },
                        ),

                        Insets.gapW5,

                        // Count
                        Text(
                          '${r.reactionCount}',
                          style: const TextStyle(
                            color: AppColors.textLightGreyColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  )
              else
                const Text(
                  'No reactions yet',
                  style: TextStyle(
                    color: AppColors.textLightGreyColor,
                    fontSize: 13,
                  ),
                )
            ],
          ),

          SizedBox(
            width: top3reactions == null ? 73 : 35,
          ),
        ],
      ),
    );
  }
}
