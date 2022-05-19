import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

/// A scrollable rounded bottom sheet with a pre-designed header
class CustomScrollableBottomSheet extends StatelessWidget {
  /// This gives the bottom sheet title.
  final String? titleText;

  /// The widget to use at the start of the header.
  final Widget? leading;

  /// The widget to use in place of title in the header.
  final Widget? title;

  /// The widget to use at the end of the header.
  final Widget? trailing;

  /// The callback used to define how the sheet child will be built.
  final ScrollableWidgetBuilder builder;

  final double initialSheetSize;
  final double minSheetSize;
  final double maxSheetSize;
  final bool expand;
  final bool snap;
  final List<double> snapSizes;

  const CustomScrollableBottomSheet({
    super.key,
    required this.builder,
    this.titleText,
    this.leading,
    this.title,
    this.trailing,
    this.initialSheetSize = 0.7,
    this.minSheetSize = 0.5,
    this.maxSheetSize = 1,
    this.expand = false,
    this.snap = true,
    this.snapSizes = const [0.7, 1],
  })  : assert(
          titleText == null || title == null,
          'Cannot specify both sheetTitle and title widget',
        );

  @override
  Widget build(BuildContext context) {
    Widget? child;
    return DraggableScrollableSheet(
      initialChildSize: initialSheetSize,
      minChildSize: minSheetSize,
      maxChildSize: maxSheetSize,
      expand: expand,
      snap: snap,
      snapSizes: snapSizes,
      builder: (_, scrollController) {
        child ??= Column(
          children: [
            // Handle
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: FractionallySizedBox(
                widthFactor: 0.25,
                child: SizedBox(
                  height: 5,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.greyOutlineColor,
                      borderRadius: Corners.rounded4,
                    ),
                  ),
                ),
              ),
            ),
        
            Insets.gapH5,
        
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: trailing != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  // Leading
                  if (leading != null) leading!,
        
                  // Title
                  title ??
                      Text(
                        titleText ?? 'Title',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
        
                  // Trailing
                  if (trailing != null) trailing!,
                ],
              ),
            ),
        
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 0,
                thickness: 1.2,
                color: Color(0xFFE0E0E0),
              ),
            ),
        
            // Child builder
            Expanded(
              child: builder(context, scrollController),
            ),
          ],
        );
        return child!;
      },
    );
  }
}
