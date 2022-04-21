import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';

class RequestTypeTabBar extends StatelessWidget {
  const RequestTypeTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      labelColor: AppColors.primaryColor,
      indicatorWeight: 3,
      indicatorColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.textLightGreyColor,
      tabs: [
        Tab(child: Text('Received')),
        Tab(child: Text('Sent')),
      ],
    );
  }
}
