import 'package:flutter/material.dart';

// Models
import '../../../requests/enums/connection_status_enum.dart';
import '../../models/student_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';

// Widgets
import '../../../shared/widgets/custom_text_button.dart';

class StudentConnectionButtons extends StatelessWidget {
  final ProfileStudentConnectionModel? studentConnection;
  final String myErp, studentErp;

  const StudentConnectionButtons({
    super.key,
    this.studentConnection,
    required this.myErp,
    required this.studentErp,
  });

  bool get isReceiver => myErp == studentConnection?.receiverErp;
  bool get isRequestPending =>
      studentConnection?.connectionStatus == ConnectionStatus.REQUEST_PENDING;
  bool get isFriends =>
      studentConnection?.connectionStatus == ConnectionStatus.FRIENDS;
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
