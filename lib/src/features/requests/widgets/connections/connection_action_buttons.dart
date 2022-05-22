import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/connection_request_provider.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/constants/app_utils.dart';

// States
import '../../../shared/states/future_state.codegen.dart';

// Widgets
import '../../../shared/widgets/custom_circular_loader.dart';
import '../../../shared/widgets/custom_text_button.dart';

class ConnectionActionButtons extends ConsumerWidget {
  final bool isReceived;
  final int studentConnectionId;
  final VoidCallback onActionSuccess;

  const ConnectionActionButtons({
    super.key,
    required this.studentConnectionId,
    required this.isReceived,
    required this.onActionSuccess,
  });

  ConnectionRequestProvider readController(WidgetRef ref) {
    return ref.read(
      connectionRequestProvider(studentConnectionId).notifier,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<FutureState<String>>(
      connectionRequestProvider(studentConnectionId),
      (_, next) => next.whenOrNull(
        data: (message) {
          AppUtils.showFlushBar(
            context: context,
            message: message,
            icon: Icons.check_circle_rounded,
            iconColor: Colors.green,
          );
          return onActionSuccess();
        },
        failed: (reason) => AppUtils.showFlushBar(
          context: context,
          message: reason,
        ),
      ),
    );
    final requestState = ref.watch(
      connectionRequestProvider(studentConnectionId),
    );
    return requestState.maybeWhen(
      loading: () => const CustomCircularLoader(),
      orElse: () => Column(
        mainAxisAlignment: isReceived
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          // Secondary
          CustomTextButton.outlined(
            width: 80,
            height: 30,
            onPressed: () {
              if (isReceived) {
                readController(ref).rejectFriendRequest();
              } else {
                readController(ref).cancelSentRequest();
              }
            },
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

          // Primary
          if (isReceived)
            CustomTextButton.gradient(
              width: 80,
              height: 30,
              onPressed: () {
                readController(ref).acceptFriendRequest();
              },
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
        ],
      ),
    );
  }
}
