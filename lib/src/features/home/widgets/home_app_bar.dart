import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/tab_item_model.dart';

// Providers
import '../../auth/providers/auth_provider.dart';
import '../providers/home_provider.dart';

// Routing
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';

class HomeAppBar extends ConsumerWidget {
  final List<TabItemModel> tabs;
  const HomeAppBar({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTabIndex = ref.watch(homeActiveTabProvider);
    return SliverAppBar(
      elevation: 0,
      toolbarHeight: 60,
      pinned: true,
      title: Text(tabs[activeTabIndex].tabName),
      backgroundColor: AppColors.lightBackgroundColor,
      leading: InkWell(
        onTap: () => ref.read(authProvider.notifier).logout(),
        child: const RotatedBox(
          quarterTurns: 2,
          child: Icon(Icons.logout_rounded, color: AppColors.redColor),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person_rounded),
          onPressed: () => AppRouter.pushNamed(Routes.ProfileScreenRoute),
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: AppColors.lightOutlineColor,
                width: 1.5,
              ),
            ),
          ),
          padding: const EdgeInsets.only(top: 2),
          child: TabBar(
            labelColor: AppColors.primaryColor,
            indicatorWeight: 3,
            indicatorColor: AppColors.primaryColor,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            unselectedLabelColor: AppColors.textLightGreyColor,
            tabs: tabs.map((t) => Tab(icon: Icon(t.icon))).toList(),
            onTap: (i) => ref.read(homeActiveTabProvider.notifier).state = i,
          ),
        ),
      ),
    );
  }
}
