import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../models/student_connection_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/extensions/datetime_extension.dart';

// Widgets
import '../../../shared/widgets/custom_network_image.dart';

class ConnectionListItem extends ConsumerWidget {
  final StudentConnectionModel studentConnection;
  final bool isReceived;
  final Animation<double> animation;
  final Widget? actions;

  const ConnectionListItem({
    super.key,
    required this.studentConnection,
    required this.animation,
    required this.isReceived,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final author =
        isReceived ? studentConnection.sender : studentConnection.receiver;
    return SizeTransition(
      sizeFactor: CurveTween(
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInCirc,
            reverseCurve: Curves.easeOutCirc,
          ),
        ),
        child: Container(
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
              if (actions != null) actions!,
            ],
          ),
        ),
      ),
    );
  }
}
