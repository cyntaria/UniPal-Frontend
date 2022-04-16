import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/typedefs.dart';

// Widgets
import '../../../shared/widgets/custom_text_button.dart';

class StudentConnectionButtons extends StatelessWidget {
  final JSON? studentConnection;
  final String myErp, studentErp;

  const StudentConnectionButtons({
    Key? key,
    this.studentConnection,
    required this.myErp,
    required this.studentErp,
  }) : super(key: key);

  bool get isReceiver => myErp == studentConnection!['receiver_erp'];
  bool get isRequestPending =>
      studentConnection!['connection_status'] == 'request_pending';
  bool get isFriends => studentConnection!['connection_status'] == 'friends';
  bool get isNotConnected => studentConnection == null;

  Widget _buildPrimaryButton(String text) {
    return CustomTextButton.gradient(
      width: 131,
      height: 40,
      onPressed: () {},
      gradient: AppColors.buttonGradientPurple,
      child: Center(
        child: Text(
          text,
          style: AppTypography.secondary.title18.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text) {
    return CustomTextButton.outlined(
      width: 131,
      height: 40,
      onPressed: () {},
      border: Border.all(
        color: AppColors.primaryColor,
        width: 1.2,
      ),
      child: Center(
        child: Text(
          text,
          style: AppTypography.secondary.title18.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isNotConnected)
          _buildPrimaryButton('Add Friend')
        else if (isRequestPending && !isReceiver)
          _buildSecondaryButton('Cancel Request')
        else if (isFriends)
          _buildSecondaryButton('Unfriend')
        else if (isRequestPending && isReceiver) ...[
          _buildPrimaryButton('Accept'),
          Insets.gapW15,
          _buildSecondaryButton('Reject'),
        ],
      ],
    );
  }
}
