import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';
import '../../../helpers/extensions/datetime_extension.dart';
import '../../../helpers/typedefs.dart';

// Widgets
import 'reactions/reaction_picker.dart';
import 'reactions/post_reactions_count.dart';

class PostListItem extends StatelessWidget {
  final JSON post;

  const PostListItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: ColoredBox(
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
                          SizedBox(
                            height: 40,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Author Avatar
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    post['author']['profile_picture_url']!
                                        as String,
                                  ),
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
                                        '${post['author']['first_name']} ${post['author']['last_name']}',
                                        style: AppTypography.primary.body14
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      // Post Datetime
                                      Text(
                                        DateTime.parse(
                                          post['posted_at']! as String,
                                        ).toTimeAgoLabel(),
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

                          Insets.gapH15,

                          // Body Text
                          Text(
                            post['body']! as String,
                            style: AppTypography.primary.body14.copyWith(
                              color: Colors.black54,
                            ),
                          ),

                          if (post['resources'] != null) ...[
                            Insets.gapH15,

                            // Post Resources Box
                            Container(
                              height: 250,
                              width: double.infinity,
                              color: Colors.blue,
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),

                  // Top 3 Reactions Count
                  const PostReactionsCount(),
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
      ),
    );
  }
}
