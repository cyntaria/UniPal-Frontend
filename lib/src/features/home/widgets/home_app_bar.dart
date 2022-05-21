import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/tab_item_model.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// Routing
import '../../../config/routes/routes.dart';
import '../../../config/routes/app_router.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';

// Widgets
import '../../shared/widgets/custom_network_image.dart';

class HomeAppBar extends ConsumerStatefulWidget {
  final List<TabItemModel> tabs;
  const HomeAppBar({
    super.key,
    required this.tabs,
  });

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends ConsumerState<HomeAppBar> {
  int activeTabIndex = 0;

  void _openProfileScreen() {
    AppRouter.pushNamed(Routes.ProfileScreenRoute);
  }

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
        // Author Avatar
        IconButton(
          padding: const EdgeInsets.only(right: 10),
          onPressed: _openProfileScreen,
          icon: Consumer(
            builder: (_, ref, __) {
              final authorProfilePicture = ref.watch(
                currentStudentProvider.select(
                  (value) => value?.profilePictureUrl,
                ),
              );
              return authorProfilePicture == null
                  ? const SizedBox.shrink()
                  : Container(
                      height: 34,
                      width: 34,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                      ),
                      child: CustomNetworkImage(
                        shape: BoxShape.circle,
                        imageUrl: authorProfilePicture,
                      ),
                    );
            },
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
