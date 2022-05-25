import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Enums
import '../../enums/day_enum.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/extensions/string_extension.dart';

class WeekdayTitle extends ConsumerWidget {
  final int weekday;
  final double height, width;

  const WeekdayTitle({
    super.key,
    required this.weekday,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekdayTitle = Day.values[weekday].name;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightOutlineColor,
            width: 1.1,
          ),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 6),
      alignment: Alignment.bottomCenter,
      child: Text(
        weekdayTitle.capitalize,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
