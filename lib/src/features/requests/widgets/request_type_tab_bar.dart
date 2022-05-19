import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';

class RequestTypeTabBar extends StatelessWidget {
  const RequestTypeTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.white,
      child: TabBar(
        labelColor: AppColors.primaryColor,
        indicatorWeight: 3,
        indicatorColor: AppColors.primaryColor,
        unselectedLabelColor: AppColors.textLightGreyColor,
        tabs: [
          Tab(child: Text('Connections')),
          Tab(child: Text('Hangouts')),
        ],
      ),
    );
  }
}
