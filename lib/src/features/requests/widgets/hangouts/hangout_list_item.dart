import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/extensions/datetime_extension.dart';

// Widgets
import '../../../shared/widgets/custom_network_image.dart';
import '../../../shared/widgets/labeled_widget.dart';
import 'hangout_action_buttons.dart';

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
      height: 235,
      padding: const EdgeInsets.all(15),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Other Author Image
              CustomNetworkImage(
                width: 50,
                height: 45,
                borderRadius: Corners.rounded4,
                fit: BoxFit.cover,
                imageUrl: authorImageUrl,
              ),

              Insets.gapW10,

              // Author Name and ERP
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author Name
                  Text(
                    '$authorName ',
                    style: AppTypography.primary.body14,
                  ),

                  Insets.gapH5,

                  // ERP
                  Text(
                    '($authorErp)',
                    style: AppTypography.primary.subtitle13.copyWith(
                      color: AppColors.textLightGreyColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Insets.gapH15,

          // Hangout Purpose
          LabeledWidget(
            label: 'Purpose',
            labelGap: Insets.gapH3,
            labelStyle: AppTypography.primary.body14,
            child: Text(
              purpose,
              style: AppTypography.primary.subtitle13.copyWith(
                color: AppColors.textLightGreyColor,
              ),
            ),
          ),

          Insets.gapH15,

          // Meetup Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Meeting Spot
              LabeledWidget(
                label: 'Meetup Spot',
                labelGap: Insets.gapH3,
                labelStyle: AppTypography.primary.body14,
                child: Text(
                  '$meetupSpotId',
                  style: AppTypography.primary.subtitle13.copyWith(
                    color: AppColors.textLightGreyColor,
                  ),
                ),
              ),

              // Meetup Datetime
              LabeledWidget(
                label: 'Meetup At',
                labelGap: Insets.gapH3,
                labelStyle: AppTypography.primary.body14,
                child: Text(
                  meetupAt.toDateString(),
                  style: AppTypography.primary.subtitle13.copyWith(
                    color: AppColors.textLightGreyColor,
                  ),
                ),
              ),
            ],
          ),

          Insets.gapH20,

          // Action Buttons
          HangoutActionButtons(
            isReceived: isReceived,
          ),
        ],
      ),
    );
  }
}
