import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/hangout_request_provider.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/constants/app_utils.dart';

// Widgets
import '../../../shared/states/future_state.codegen.dart';
import '../../../shared/widgets/custom_circular_loader.dart';
import '../../../shared/widgets/custom_text_button.dart';

class HangoutActionButtons extends ConsumerWidget {
  final bool isReceived;
  final int hangoutRequestId;
  final VoidCallback onActionSuccess;

  const HangoutActionButtons({
    super.key,
    required this.isReceived,
    required this.hangoutRequestId,
    required this.onActionSuccess,
  });

  HangoutRequestProvider readController(WidgetRef ref) {
    return ref.read(
      hangoutRequestProvider(hangoutRequestId).notifier,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<FutureState<String>>(
      hangoutRequestProvider(hangoutRequestId),
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
      hangoutRequestProvider(hangoutRequestId),
    );
    return requestState.maybeWhen(
      loading: () => const Padding(
        padding: EdgeInsets.only(right: 15),
        child: CustomCircularLoader(),
      ),
      orElse: () => Row(
        mainAxisAlignment: isReceived
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          // Secondary
          Expanded(
            child: CustomTextButton.outlined(
              height: 35,
              onPressed: () {
                if (isReceived) {
                  readController(ref).rejectHangoutRequest();
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
          ),

          // Primary
          if (isReceived) ...[
            Insets.gapW15,
            Expanded(
              child: CustomTextButton.gradient(
                height: 35,
                onPressed: () {
                  readController(ref).acceptHangoutRequest();
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
            )
          ],
        ],
      ),
    );
  }
}
