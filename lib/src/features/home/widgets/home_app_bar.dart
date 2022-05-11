import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/tab_item_model.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// Routing
import '../../../config/routes/app_router.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';

// Screens
import '../../profile/screens/profile_screen.dart';

class HomeAppBar extends ConsumerStatefulWidget {
  final List<TabItemModel> tabs;
  const HomeAppBar({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends ConsumerState<HomeAppBar> {
  int activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      toolbarHeight: 60,
      pinned: true,
      title: Text(widget.tabs[activeTabIndex].tabName),
      backgroundColor: AppColors.lightBackgroundColor,
      leading: InkWell(
        onTap: ref.read(authProvider.notifier).logout,
        child: const RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.logout_rounded,
            color: AppColors.redColor,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person_rounded),
          onPressed: () => AppRouter.push(
            ProfileScreen(
              student: ref.watch(currentStudentProvider)!,
              isMyProfile: true,
            ),
          ),
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
            tabs: widget.tabs.map((t) => Tab(icon: Icon(t.icon))).toList(),
            onTap: (i) => setState(() => activeTabIndex = i),
          ),
        ),
      ),
    );
  }
}
