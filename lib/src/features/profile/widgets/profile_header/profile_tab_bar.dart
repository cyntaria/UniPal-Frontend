import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverTabBarDelegate(
        const TabBar(
          isScrollable: true,
          labelColor: Colors.black87,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          indicatorWeight: 3,
          indicatorColor: AppColors.primaryColor,
          labelPadding: EdgeInsets.symmetric(horizontal: 25),
          padding: EdgeInsets.symmetric(horizontal: 20),
          unselectedLabelColor: AppColors.textLightGreyColor,
          unselectedLabelStyle: TextStyle(),
          tabs: [
            Tab(
              child: Text('PREFERENCES'),
            ),
            Tab(
              child: Text('ABOUT'),
            ),
            Tab(
              child: Text('ACTIVITIES'),
            ),
          ],
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
      color: AppColors.backgroundColor,
      child: Stack(
        children: [
          // Bottom border
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(
                left: (_tabBar.padding?.horizontal ?? 20) - 15,
                bottom: 0.9,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.lightOutlineColor),
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
