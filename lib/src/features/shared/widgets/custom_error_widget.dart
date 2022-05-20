import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

//Services
import '../../../core/networking/custom_exception.dart';

//Widgets
import 'custom_text_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final CustomException error;
  final Color backgroundColor;
  final double height;
  final VoidCallback retryCallback;

  const CustomErrorWidget._({
    required this.error,
    required this.backgroundColor,
    required this.retryCallback,
    required this.height,
  });

  const factory CustomErrorWidget.dark({
    required CustomException error,
    required VoidCallback retryCallback,
    double? height,
  }) = _CustomErrorWidgetDark;

  const factory CustomErrorWidget.light({
    required CustomException error,
    required VoidCallback retryCallback,
    double? height,
  }) = _CustomErrorWidgetLight;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTypography.primary;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: Corners.rounded15,
        ),
        height: height,
        padding: const EdgeInsets.fromLTRB(30, 25, 30, 35),
        child: Center(
          child: Column(
            children: [
              Text(
                'Oops',
                style: textTheme.heading34.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 45,
                ),
              ),
              Insets.gapH30,
              Text(
                error.message,
                textAlign: TextAlign.center,
                style: textTheme.body16.copyWith(fontSize: 21),
              ),
              const Spacer(),
              CustomTextButton.gradient(
                width: double.infinity,
                onPressed: retryCallback,
                gradient: AppColors.buttonGradientPurple,
                child: Center(
                  child: Text(
                    'RETRY',
                    style: textTheme.label12.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomErrorWidgetDark extends CustomErrorWidget {
  const _CustomErrorWidgetDark({
    required super.error,
    required super.retryCallback,
    double? height,
  }) : super._(
          backgroundColor: AppColors.scaffoldGreyColor,
          height: height ?? double.infinity,
        );
}

class _CustomErrorWidgetLight extends CustomErrorWidget {
  const _CustomErrorWidgetLight({
    required super.error,
    required super.retryCallback,
    double? height,
  }) : super._(
          backgroundColor: AppColors.surfaceColor,
          height: height ?? double.infinity,
        );
}
