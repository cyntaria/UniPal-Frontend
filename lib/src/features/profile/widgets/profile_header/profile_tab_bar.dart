import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';

class ProfileTabBar extends StatelessWidget {
  final List<String> tabNames;

  const ProfileTabBar({
    super.key,
    required this.tabNames,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverTabBarDelegate(
        TabBar(
          isScrollable: true,
          labelColor: Colors.black87,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          indicatorWeight: 3,
          indicatorColor: AppColors.primaryColor,
          labelPadding: const EdgeInsets.symmetric(horizontal: 25),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          unselectedLabelColor: AppColors.textLightGreyColor,
          unselectedLabelStyle: const TextStyle(),
          tabs: tabNames.map((e) => Tab(child: Text(e))).toList(),
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, _, __) {
    return ColoredBox(
      color: AppColors.lightBackgroundColor,
      child: Stack(
        children: [
          // Bottom border
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.only(bottom: 0.9),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.greyOutlineColor),
                ),
              ),
              width: _tabBar.preferredSize.width,
            ),
          ),

          _tabBar,
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
