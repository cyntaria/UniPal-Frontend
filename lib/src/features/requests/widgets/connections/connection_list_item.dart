import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../models/student_connection_model.codegen.dart';

// Providers
import '../../../auth/providers/auth_provider.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/extensions/datetime_extension.dart';

// Widgets
import '../../../shared/widgets/custom_network_image.dart';
import 'connection_action_buttons.dart';

class ConnectionListItem extends ConsumerWidget {
  final StudentConnectionModel studentConnection;

  const ConnectionListItem({
    super.key,
    required this.studentConnection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isReceived = ref.watch(
      currentStudentProvider.select(
        (value) => value!.erp == studentConnection.receiver.erp,
      ),
    );
    final author =
        isReceived ? studentConnection.receiver : studentConnection.sender;
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
            imageUrl: author.profilePictureUrl,
          ),

          Insets.gapW10,

          // Author Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${author.firstName} ${author.lastName}',
                  style: AppTypography.primary.body14.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  author.erp,
                  style: AppTypography.primary.subtitle13,
                ),

                // Request Sent Datetime
                Text(
                  studentConnection.sentAt.toTimeAgoLabel(),
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
            studentConnectionId: studentConnection.studentConnectionId,
          ),
        ],
      ),
    );
  }
}
