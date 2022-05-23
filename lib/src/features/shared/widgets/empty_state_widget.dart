import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/lottie_assets.dart';

class EmptyStateWidget extends StatelessWidget {
  final double height, width;
  final Widget? animation;
  final String? subtitle;
  final String? title;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const EmptyStateWidget({
    super.key,
    this.animation,
    this.subtitle,
    this.title,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            animation ??
                Lottie.asset(
                  LottieAssets.emptySearchLottie,
                  width: 250,
                  height: 250,
                ),

            // Info
            Padding(
              padding: padding,
              child: Column(
                children: [
                  // Title
                  Text(
                    title ?? 'No results found.',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Insets.gapH5,

                  // Subtitle
                  Text(
                    subtitle ?? 'Check again at a later time',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textGreyColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
