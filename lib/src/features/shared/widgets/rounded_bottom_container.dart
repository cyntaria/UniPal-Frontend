import 'package:flutter/material.dart';

//Routing
import '../../../config/routes/app_router.dart';

//Helpers
import '../../../helpers/constants/app_colors.dart';

class RoundedBottomContainer extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onBackTap;
  final EdgeInsets? padding;

  const RoundedBottomContainer({
    super.key,
    required this.children,
    this.onBackTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back arrow
          InkWell(
            onTap: onBackTap ?? AppRouter.pop,
            child: const Padding(
              padding: EdgeInsets.only(left: 25.0 - 5, top: 40),
              child: Icon(
                Icons.arrow_back_sharp,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),

          Padding(
            padding: padding ?? const EdgeInsets.fromLTRB(25, 28, 25, 27),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
