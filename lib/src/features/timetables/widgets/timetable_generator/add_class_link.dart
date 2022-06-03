import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// Providers
import '../../providers/classes_selector_provider.dart';

// Helpers
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../shared/widgets/custom_text_button.dart';

class AddClassLink extends ConsumerWidget {
  const AddClassLink({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTextButton(
      height: 35,
      width: 65,
      onPressed: ref.read(classesSelectorProvider.notifier).addClass,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Add Text
          Text(
            'Add',
            style: AppTypography.primary.body16.copyWith(
              color: AppColors.lightPrimaryColor,
            ),
          ),

          Insets.gapW10,

          // Plus Icon
          const Expanded(
            child: Icon(
              Icons.add_circle_outline_rounded,
              size: IconSizes.med22,
              color: AppColors.lightPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}
