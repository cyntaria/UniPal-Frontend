import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

class CustomChipsList extends StatelessWidget {
  final List<String> chipContents;
  final double chipHeight, chipGap;
  final double? chipWidth;
  final double fontSize;
  final bool isScrollable;
  final FontWeight? fontWeight;
  final double borderWidth;
  final Color borderColor, backgroundColor, contentColor;

  const CustomChipsList({
    super.key,
    this.fontWeight,
    this.chipWidth,
    this.chipGap = 0.0,
    this.fontSize = 12,
    this.borderWidth = 1.0,
    this.isScrollable = false,
    this.borderColor = AppColors.textGreyColor,
    this.backgroundColor = Colors.white,
    this.contentColor = AppColors.textGreyColor,
    required this.chipContents,
    required this.chipHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: chipHeight,
      child: isScrollable
          ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: chipContents.length,
              separatorBuilder: (ctx, i) => SizedBox(width: chipGap),
              itemBuilder: (ctx, i) => buildChipListItem(i),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < chipContents.length; i++)
                  Padding(
                    padding: EdgeInsets.only(left: i == 0 ? 0 : chipGap),
                    child: buildChipListItem(i),
                  )
              ],
            ),
    );
  }

  Container buildChipListItem(int i) {
    return Container(
      width: chipWidth,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: Corners.rounded20,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: Center(
        child: Text(
          chipContents[i],
          style: TextStyle(
            color: contentColor,
            fontSize: fontSize,
            height: 1,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
