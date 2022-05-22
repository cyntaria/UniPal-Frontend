import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../../profile/models/student_model.codegen.dart';

// States
import '../../../shared/states/future_state.codegen.dart';

// Providers
import '../../providers/profile_connection_provider.dart';

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

class ConnectionButtons extends ConsumerStatefulWidget {
  final ProfileStudentConnectionModel? studentConnection;
  final String myErp, studentErp;

  const ConnectionButtons({
    super.key,
    this.studentConnection,
    required this.myErp,
    required this.studentErp,
  });

  @override
  _ConnectionButtonsState createState() => _ConnectionButtonsState();
}

class _ConnectionButtonsState extends ConsumerState<ConnectionButtons> {
  ProfileStudentConnectionModel? studentConnection;

  bool get isReceiver => widget.myErp == studentConnection?.receiverErp;

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
  void initState() {
    super.initState();
    studentConnection = widget.studentConnection;
  }

  void updateConnectionState(ProfileStudentConnectionModel? connection) {
    setState(() {
      studentConnection = connection;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<FutureState<String>>(
      profileConnectionProvider,
      (_, next) => next.whenOrNull(
        data: (message) => AppUtils.showFlushBar(
          context: context,
          message: message,
          icon: Icons.check_circle_rounded,
          iconColor: Colors.green,
        ),
        failed: (reason) => AppUtils.showFlushBar(
          context: context,
          message: reason,
        ),
      ),
    );
    final profileConnectionState = ref.watch(profileConnectionProvider);
    return profileConnectionState.maybeWhen(
      loading: () => const CustomCircularLoader(),
      orElse: () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isNotConnected)
            _buildPrimaryButton(
              'Add Friend',
              onPressed: () async {
                final connection = await ref
                    .read(profileConnectionProvider.notifier)
                    .addFriend(widget.studentErp);
                updateConnectionState(connection);
              },
            )
          else if (isRequestPending && !isReceiver)
            _buildSecondaryButton(
              'Cancel Request',
              onPressed: () async {
                final success = await ref
                    .read(profileConnectionProvider.notifier)
                    .cancelSentRequest(
                      studentConnection!.studentConnectionId,
                    );
                if (success) updateConnectionState(null);
              },
            )
          else if (isFriends)
            _buildSecondaryButton(
              'Unfriend',
              onPressed: () async {
                final success = await ref
                    .read(profileConnectionProvider.notifier)
                    .unFriend(studentConnection!.studentConnectionId);
                if (success) updateConnectionState(null);
              },
            )
          else if (isRequestPending && isReceiver) ...[
            // Accept Button
            _buildPrimaryButton(
              'Accept',
              onPressed: () async {
                final connection = await ref
                    .read(profileConnectionProvider.notifier)
                    .acceptFriendRequest(studentConnection!);
                updateConnectionState(connection);
              },
            ),

            Insets.gapW15,

            // Reject Button
            _buildSecondaryButton(
              'Reject',
              onPressed: () async {
                final success = await ref
                    .read(profileConnectionProvider.notifier)
                    .rejectFriendRequest(
                      studentConnection!.studentConnectionId,
                    );
                if (success) updateConnectionState(null);
              },
            ),
          ],
        ],
      ),
    );
  }
}
