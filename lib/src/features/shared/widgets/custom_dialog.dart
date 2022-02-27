// ignore_for_file: unused_field

import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart' as AppStyles;
import '../../../helpers/constants/app_typography.dart';

//Routing
import '../../../config/routes/app_router.dart';

//Widgets
import 'custom_text_button.dart';

// ignore: constant_identifier_names
enum _CustomDialogType { ALERT, CONFIRM, ABOUT, SIMPLE }

class CustomDialog extends StatelessWidget {
  final String title, body;
  final String? buttonText, falseButtonText, trueButtonText;
  final _CustomDialogType _type;
  final VoidCallback? falseButtonPressed, trueButtonPressed;

  const CustomDialog._({
    this.buttonText,
    this.falseButtonText,
    this.trueButtonText,
    this.falseButtonPressed,
    this.trueButtonPressed,
    required this.title,
    required this.body,
    required _CustomDialogType type,
  }) : _type = type;

  const factory CustomDialog.alert({
    required String title,
    required String body,
    required String buttonText,
    VoidCallback? onButtonPressed,
  }) = _CustomDialogWithAlert;

  const factory CustomDialog.confirm({
    required String title,
    required String body,
    required String falseButtonText,
    required String trueButtonText,
    VoidCallback? falseButtonPressed,
    VoidCallback? trueButtonPressed,
  }) = _CustomDialogWithConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: AppStyles.Corners.rounded10,
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 19),
      titlePadding: const EdgeInsets.fromLTRB(19, 14, 19, 0),
      contentPadding: const EdgeInsets.fromLTRB(19, 9, 19, 9),
      actionsPadding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
      backgroundColor: AppColors.scaffoldGreyColor,
      title: Text(title),
      content: Text(body),
      contentTextStyle: AppTypography.primary.body14.copyWith(
        color: AppColors.textGreyColor,
        fontSize: FontSizes.f16,
      ),
      titleTextStyle: AppTypography.primary.body14.copyWith(
        color: AppColors.textWhite80Color,
        fontSize: FontSizes.f18,
      ),
      actions: <Widget>[
        if (_type == _CustomDialogType.ALERT)
          CustomTextButton.gradient(
            gradient: AppColors.buttonGradientRed,
            height: 40,
            width: 60,
            onPressed: () {
              trueButtonPressed?.call();
              AppRouter.pop();
            },
            child: Center(
              child: Text(
                buttonText!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        else if (_type == _CustomDialogType.CONFIRM) ...[
          CustomTextButton.outlined(
            border: Border.all(color: AppColors.primaryColor),
            height: 40,
            width: 60,
            onPressed: () {
              trueButtonPressed?.call();
              AppRouter.pop(true);
            },
            child: Center(
              child: Text(
                trueButtonText!,
                style: const TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ),
          CustomTextButton.gradient(
            gradient: AppColors.buttonGradientRed,
            height: 40,
            width: 60,
            onPressed: () {
              falseButtonPressed?.call();
              AppRouter.pop(false);
            },
            child: Center(
              child: Text(
                falseButtonText!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]
      ],
    );
  }
}

class _CustomDialogWithAlert extends CustomDialog {
  const _CustomDialogWithAlert({
    required String title,
    required String body,
    required String buttonText,
    VoidCallback? onButtonPressed,
  }) : super._(
          title: title,
          body: body,
          buttonText: buttonText,
          trueButtonPressed: onButtonPressed,
          type: _CustomDialogType.ALERT,
        );
}

class _CustomDialogWithConfirm extends CustomDialog {
  const _CustomDialogWithConfirm({
    required String title,
    required String body,
    required String falseButtonText,
    required String trueButtonText,
    VoidCallback? falseButtonPressed,
    VoidCallback? trueButtonPressed,
  }) : super._(
          title: title,
          body: body,
          falseButtonText: falseButtonText,
          trueButtonText: trueButtonText,
          falseButtonPressed: falseButtonPressed,
          trueButtonPressed: trueButtonPressed,
          type: _CustomDialogType.CONFIRM,
        );
}
