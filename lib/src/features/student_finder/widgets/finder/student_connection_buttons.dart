import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../../profile/models/student_model.codegen.dart';

// States
import '../../../shared/states/future_state.codegen.dart';

// Providers
import '../../providers/profile_connection_provider.dart';
import '../../providers/students_provider.dart';

// Helpers
import '../../../../helpers/constants/app_utils.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';

// Enums
import '../../../requests/enums/connection_status_enum.dart';

// Widgets
import '../../../shared/widgets/custom_circular_loader.dart';
import '../../../shared/widgets/custom_text_button.dart';

class StudentConnectionButtons extends ConsumerWidget {
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

  Widget _buildPrimaryButton(String text, {required VoidCallback onPressed}) {
    return CustomTextButton.gradient(
      width: 131,
      height: 40,
      onPressed: onPressed,
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

  Widget _buildSecondaryButton(String text, {required VoidCallback onPressed}) {
    return CustomTextButton.outlined(
      width: 131,
      height: 40,
      onPressed: onPressed,
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
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<FutureState<String>>(
      profileConnectionProvider,
      (_, next) => next.whenOrNull(
        data: (message) => AppUtils.showFlushBar(
          context: context,
          message: message,
          icon: Icons.check_circle_rounded,
        ),
        failed: (reason) => AppUtils.showFlushBar(
          context: context,
          message: reason,
          icon: Icons.remove_circle_rounded,
        ),
      ),
    );
    final profileConnectionState = ref.watch(profileConnectionProvider);
    return profileConnectionState.maybeWhen(
      loading: () => const CustomCircularLoader(
        color: AppColors.primaryColor,
      ),
      orElse: () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isNotConnected)
            _buildPrimaryButton(
              'Add Friend',
              onPressed: () {
                ref
                    .read(profileConnectionProvider.notifier)
                    .addFriend(studentErp);
                ref.refresh(othersProfileFutureProvider(studentErp));
              },
            )
          else if (isRequestPending && !isReceiver)
            _buildSecondaryButton(
              'Cancel Request',
              onPressed: () {
                ref
                    .read(profileConnectionProvider.notifier)
                    .deleteFriendRequest(
                      studentConnection!.studentConnectionId,
                    );
                ref.refresh(othersProfileFutureProvider(studentErp));
              },
            )
          else if (isFriends)
            _buildSecondaryButton(
              'Unfriend',
              onPressed: () {
                ref
                    .read(profileConnectionProvider.notifier)
                    .deleteFriendRequest(
                      studentConnection!.studentConnectionId,
                    );
                ref.refresh(othersProfileFutureProvider(studentErp));
              },
            )
          else if (isRequestPending && isReceiver) ...[
            // Accept Button
            _buildPrimaryButton(
              'Accept',
              onPressed: () {
                ref
                    .read(profileConnectionProvider.notifier)
                    .acceptFriendRequest(
                      studentConnection!.studentConnectionId,
                    );
                ref.refresh(othersProfileFutureProvider(studentErp));
              },
            ),

            Insets.gapW15,

            // Reject Button
            _buildSecondaryButton(
              'Reject',
              onPressed: () {
                ref
                    .read(profileConnectionProvider.notifier)
                    .deleteFriendRequest(
                      studentConnection!.studentConnectionId,
                    );
                ref.refresh(othersProfileFutureProvider(studentErp));
              },
            ),
          ],
        ],
      ),
    );
  }
}
