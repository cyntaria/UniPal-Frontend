import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

class PostReactions extends StatelessWidget {
  const PostReactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Insets.gapW30,

          // React Button
          InkWell(
            onTap: () {},
            child: Row(
              children: const [
                // Icon
                Icon(
                  Icons.add_reaction_rounded,
                  size: 21,
                  color: AppColors.textLightGreyColor,
                ),

                Insets.gapW10,

                // Text
                Text(
                  'React',
                  style: TextStyle(
                    color: AppColors.textLightGreyColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Insets.gapW30,

          const VerticalDivider(
            color: AppColors.lightOutlineColor,
            width: 0,
          ),

          Insets.expand,

          // Top 3 Reactions
          for (var c in [
            Colors.amber,
            Colors.red,
            Colors.lightGreenAccent,
          ])
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Reaction
                  CircleAvatar(
                    backgroundColor: c,
                    radius: 8,
                  ),

                  Insets.gapW5,

                  // Count
                  const Text(
                    '20',
                    style: TextStyle(
                      color: AppColors.textLightGreyColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

          Insets.expand,
        ],
      ),
    );
  }
}
