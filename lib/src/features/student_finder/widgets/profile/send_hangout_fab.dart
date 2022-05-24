import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/profile_hangout_provider.dart';

// States
import '../../../shared/states/future_state.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_utils.dart';
import '../../../../helpers/constants/app_assets.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../shared/widgets/custom_circular_loader.dart';

class SendHangoutFAB extends ConsumerWidget {
  final VoidCallback onPressed;

  const SendHangoutFAB({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<FutureState<String>>(
      profileHangoutProvider,
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
    final hangoutFuture = ref.watch(profileHangoutProvider);
    return SizedBox(
      height: 55,
      width: 125,
      child: hangoutFuture.maybeWhen(
        loading: () => const CustomCircularLoader(
          color: Colors.white,
        ),
        orElse: () => FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          onPressed: onPressed,
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Hangout Icon
              Image.asset(
                AppAssets.hangoutIcon,
                height: 20,
                width: 20,
              ),

              Insets.gapW10,

              // Label
              const Text(
                'Hangout',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
