import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/extensions/datetime_extension.dart';

// Widgets
import '../../../shared/widgets/custom_network_image.dart';
import '../request_action_buttons.dart';

class HangoutListItem extends StatelessWidget {
  final String authorName;
  final String authorErp;
  final String authorImageUrl;
  final String purpose;
  final DateTime meetupAt;
  final int meetupSpotId;
  final bool isReceived;

  const HangoutListItem({
    Key? key,
    required this.authorImageUrl,
    required this.authorName,
    required this.authorErp,
    required this.purpose,
    required this.meetupAt,
    required this.meetupSpotId,
    required this.isReceived,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: Corners.rounded7,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE0E0E0),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Other Author Image
          CustomNetworkImage(
            width: 69,
            height: 74,
            borderRadius: Corners.rounded4,
            fit: BoxFit.cover,
            imageUrl: authorImageUrl,
          ),

          Insets.gapW10,

          // Author Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Author Name And Erp
                RichText(
                  text: TextSpan(
                    text: '$authorName ',
                    style: AppTypography.primary.body14.copyWith(
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '($authorErp)',
                        style: AppTypography.primary.body14.copyWith(
                          color: AppColors.textBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Hangout Purpose
                RichText(
                  text: TextSpan(
                    text: 'Purpose: ',
                    style: AppTypography.primary.subtitle13.copyWith(
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: purpose,
                        style: AppTypography.primary.subtitle13.copyWith(
                          color: AppColors.textBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Meeting Spot
                RichText(
                  text: TextSpan(
                    text: 'Meetup Spot: ',
                    style: AppTypography.primary.subtitle13.copyWith(
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '$meetupSpotId',
                        style: AppTypography.primary.subtitle13.copyWith(
                          color: AppColors.textBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Meetup Datetime
                RichText(
                  text: TextSpan(
                    text: 'Meetup At: ',
                    style: AppTypography.primary.subtitle13.copyWith(
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: meetupAt.toDateString(),
                        style: AppTypography.primary.subtitle13.copyWith(
                          color: AppColors.textLightGreyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons
          RequestActionButtons(
            isReceived: isReceived,
          ),
        ],
      ),
    );
  }
}
