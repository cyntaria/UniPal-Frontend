import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';
import '../../../helpers/typedefs.dart';

// Widgets
import 'post_reactions.dart';

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
        child: Column(
          children: [
            // Post body
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
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
                            post['author']['profile_picture_url']! as String,
                          ),
                        ),

                        Insets.gapW10,

                        // Author & Post Detals
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Author Name
                              Text(
                                '${post['author']['first_name']} ${post['author']['last_name']}',
                                style: AppTypography.primary.body14.copyWith(
                                  color: AppColors.textBlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // Post Datetime
                              Text(
                                DateFormat('d MM, y -- hh:mm a').format(
                                  DateTime.parse(post['posted_at']! as String),
                                ),
                                style:
                                    AppTypography.primary.subtitle13.copyWith(
                                  color: AppColors.textLightGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // More Options Icon
                        const Icon(
                          Icons.more_horiz_rounded,
                          color: AppColors.lightOutlineColor,
                        ),
                      ],
                    ),
                  ),

                  Insets.gapH15,

                  // Body Text
                  Text(
                    post['body']! as String,
                    style: AppTypography.primary.body14,
                  ),

                  Insets.gapH15,

                  // Post Resources Box
                  if (post['resources'] != null)
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.blue,
                    ),
                ],
              ),
            ),

            const Divider(
              height: 0,
              color: AppColors.lightOutlineColor,
            ),

            // Post Reactions
            const PostReactions()
          ],
        ),
      ),
    );
  }
}