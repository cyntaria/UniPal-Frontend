import 'package:flutter/material.dart';

//Helpers
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final Color activeStarColor, inActiveStarColor;
  final bool showRatingNumber;
  final double? starSize;
  final int maxStars;

  const RatingStars({
    super.key,
    required this.rating,
    this.starSize,
    this.maxStars = 5,
    this.activeStarColor = const Color.fromARGB(255, 248, 160, 59),
    this.inActiveStarColor = const Color.fromARGB(255, 224, 224, 224),
    this.showRatingNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalfStar = rating > fullStars;
    final emptyStars = maxStars - fullStars - (hasHalfStar ? 1 : 0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Rating number
        if (showRatingNumber) ...[
          Text(
            rating == 0 ? 'N/A' : rating.toString(),
            style: AppTypography.primary.body14.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Insets.gapW10,
        ],

        // Rating stars
        for (int i = 0; i < fullStars; i++)
          Padding(
            padding: i == 0
                ? const EdgeInsets.only(right: 1)
                : const EdgeInsets.symmetric(horizontal: 1),
            child: Icon(
              Icons.star_rounded,
              size: starSize,
              color: activeStarColor,
            ),
          ),

        // Half star
        if (hasHalfStar)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Icon(
              Icons.star_half_rounded,
              size: starSize,
              color: activeStarColor,
            ),
          ),

        // Empty stars
        for (int i = 0; i < emptyStars; i++)
          Padding(
            padding: i == 0
                ? const EdgeInsets.only(right: 1)
                : const EdgeInsets.symmetric(horizontal: 1),
            child: Icon(
              Icons.star_rounded,
              size: starSize,
              color: inActiveStarColor,
            ),
          ),
      ],
    );
  }
}
