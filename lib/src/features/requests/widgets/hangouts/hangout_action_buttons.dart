import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';

// Widgets
import '../../../shared/widgets/custom_text_button.dart';

class HangoutActionButtons extends StatelessWidget {
  final bool isReceived;

  const HangoutActionButtons({
    super.key,
    required this.isReceived,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isReceived
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        // Secondary
        Expanded(
          child: CustomTextButton.outlined(
            height: 35,
            onPressed: () {},
            border: Border.all(
              color: AppColors.primaryColor,
              width: 1.2,
            ),
            child: Center(
              child: Text(
                isReceived ? 'Reject' : 'Cancel',
                style: AppTypography.secondary.subtitle13.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),

        // Primary
        if (isReceived) ...[
          Insets.gapW15,

          Expanded(
            child: CustomTextButton.gradient(
              height: 35,
              onPressed: () {},
              gradient: AppColors.buttonGradientPurple,
              child: Center(
                child: Text(
                  'Accept',
                  style: AppTypography.secondary.subtitle13.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ],
    );
  }
}
