import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart' as AppStyles;
import '../../../helpers/constants/app_typography.dart';

//Services
import '../../../core/networking/network_exception.dart';

//Widgets
import 'custom_text_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final NetworkException error;
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
    required NetworkException error,
    required VoidCallback retryCallback,
    double? height,
  }) = _CustomErrorWidgetDark;

  const factory CustomErrorWidget.light({
    required NetworkException error,
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
          borderRadius: AppStyles.Corners.rounded15,
        ),
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 20),
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
              AppStyles.Insets.gapH30,
              Text(
                error.message,
                textAlign: TextAlign.center,
                style: textTheme.body16.copyWith(fontSize: 21),
              ),
              const Spacer(),
              CustomTextButton.gradient(
                width: double.infinity,
                onPressed: retryCallback,
                gradient: AppColors.buttonGradientRed,
                child: Center(
                  child: Text(
                    'RETRY',
                    style: textTheme.label12.copyWith(
                      color: Colors.white,
                      fontSize: FontSizes.f16,
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
    required NetworkException error,
    required VoidCallback retryCallback,
    double? height,
  }) : super._(
          error: error,
          backgroundColor: AppColors.scaffoldGreyColor,
          retryCallback: retryCallback,
          height: height ?? double.infinity,
        );
}

class _CustomErrorWidgetLight extends CustomErrorWidget {
  const _CustomErrorWidgetLight({
    required NetworkException error,
    required VoidCallback retryCallback,
    double? height,
  }) : super._(
          error: error,
          backgroundColor: const Color(0xFFEF9A9A),
          retryCallback: retryCallback,
          height: height ?? double.infinity,
        );
}
