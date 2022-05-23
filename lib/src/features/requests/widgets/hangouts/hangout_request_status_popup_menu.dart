import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enums
import '../../enums/hangout_request_status_enum.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/extensions/string_extension.dart';

class HangoutRequestStatusPopupMenu extends ConsumerWidget {
  final void Function(HangoutRequestStatus?) onSelected;
  final VoidCallback onCanceled;
  final HangoutRequestStatus? initialValue;

  const HangoutRequestStatusPopupMenu({
    super.key,
    required this.onSelected,
    required this.onCanceled,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<HangoutRequestStatus?>(
      elevation: 2,
      initialValue: initialValue,
      padding: EdgeInsets.zero,
      color: AppColors.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: Corners.rounded20,
      ),
      itemBuilder: (_) => [
        // All
        PopupMenuItem(
          height: 38,
          child: Text(
            'All',
            style: AppTypography.primary.body14,
            maxLines: 1,
          ),
        ),

        // Other values
        for (var status in HangoutRequestStatus.values)
          PopupMenuItem(
            value: status,
            height: 38,
            child: Text(
              status.name.removeUnderScore,
              style: AppTypography.primary.body14,
              maxLines: 1,
            ),
          ),
      ],
      onSelected: onSelected,
      onCanceled: onCanceled,
      child: const Icon(
        Icons.filter_list_rounded,
        color: AppColors.textLightGreyColor,
        size: 22,
      ),
    );
  }
}
