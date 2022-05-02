import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/extensions/datetime_extension.dart';

// Widgets
import '../../../shared/widgets/custom_network_image.dart';
import 'connection_action_buttons.dart';

class ConnectionListItem extends StatelessWidget {
  final String authorName;
  final String authorErp;
  final String authorImageUrl;
  final DateTime requestSentAt;
  final bool isReceived;

  const ConnectionListItem({
    Key? key,
    required this.authorImageUrl,
    required this.authorName,
    required this.authorErp,
    required this.requestSentAt,
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
                Text(
                  authorName,
                  style: AppTypography.primary.body14.copyWith(
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  authorErp,
                  style: AppTypography.primary.subtitle13.copyWith(
                    color: AppColors.textBlackColor,
                  ),
                ),

                // Request Sent Datetime
                Text(
                  requestSentAt.toTimeAgoLabel(),
                  style: AppTypography.primary.subtitle13.copyWith(
                    color: AppColors.textLightGreyColor,
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons
          ConnectionActionButtons(
            isReceived: isReceived,
          ),
        ],
      ),
    );
  }
}
