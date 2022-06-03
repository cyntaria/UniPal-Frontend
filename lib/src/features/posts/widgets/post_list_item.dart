import 'package:flutter/material.dart';

// Models
import '../../../config/routes/app_router.dart';
import '../../student_finder/screens/others_profile_screen.dart';
import '../models/post_model.codegen.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';
import '../../../helpers/extensions/datetime_extension.dart';

// Widgets
import '../../shared/widgets/custom_network_image.dart';
import 'post_resources_slider.dart';
import 'reactions/reaction_picker.dart';
import 'reactions/post_reactions_count.dart';

class PostListItem extends StatelessWidget {
  final PostModel post;

  const PostListItem({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      color: Colors.white,
      child: LimitedBox(
        maxHeight: 410,
        child: Stack(
          children: [
            // Post Body Window
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Post Window
                LimitedBox(
                  maxHeight: 370,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.lightOutlineColor,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Author Row
                        GestureDetector(
                          onTap: () => AppRouter.push(
                            OthersProfileScreen(erp: post.author.erp),
                          ),
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Author Avatar
                                CustomNetworkImage(
                                  height: 40,
                                  width: 40,
                                  shape: BoxShape.circle,
                                  imageUrl: post.author.profilePictureUrl,
                                ),

                                Insets.gapW10,

                                // Author & Post Detals
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Author Name
                                      Text(
                                        '${post.author.firstName} ${post.author.lastName}',
                                        style: AppTypography.primary.body14
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      // Post Datetime
                                      Text(
                                        post.postedAt.toTimeAgoLabel(),
                                        style: AppTypography.primary.subtitle13
                                            .copyWith(
                                          color: AppColors.textLightGreyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // More Options Icon
                                const Icon(
                                  Icons.more_horiz_rounded,
                                  color: AppColors.greyOutlineColor,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Insets.gapH15,

                        // Body Text
                        Text(
                          post.body,
                          style: AppTypography.primary.body14.copyWith(
                            color: AppColors.textGreyColor,
                          ),
                        ),

                        if (post.resources != null) ...[
                          Insets.gapH15,

                          // Post Resources Box
                          PostResourcesSlider(
                            resources: post.resources!,
                          ),
                        ]
                      ],
                    ),
                  ),
                ),

                // Top 3 Reactions Count
                PostReactionsCount(
                  top3reactions: post.top3Reactions,
                ),
              ],
            ),

            // Post Reactions
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ReactionPicker(),
            ),
          ],
        ),
      ),
    );
  }
}
