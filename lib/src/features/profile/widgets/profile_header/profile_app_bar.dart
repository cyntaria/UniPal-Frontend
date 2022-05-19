import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_utils.dart';

// Routing
import '../../../../config/routes/app_router.dart';

class ProfileAppBar extends StatelessWidget {
  final String title;
  final Widget profileAvatar;
  final double extent;
  final String? subtitle;
  final Widget? child;
  final Widget? trailing;
  final VoidCallback? onCameraTap;

  const ProfileAppBar({
    super.key,
    required this.title,
    required this.profileAvatar,
    this.extent = 250,
    this.trailing,
    this.subtitle,
    this.onCameraTap,
    this.child,
  })  : assert(extent >= 200, "Extent can't be less than 200");

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
        title: title,
        subtitle: subtitle,
        profileAvatar: profileAvatar,
        extent: extent,
        trailing: trailing,
        onCameraTap: onCameraTap,
        child: child,
      ),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget profileAvatar;
  final String title;
  final String? subtitle;
  final VoidCallback? onCameraTap;
  final double extent;

  final Widget? trailing;
  final Widget? child;

  static const _iconTopMargin = 21.0;
  static const _iconSideMargin = 16.0;
  static const _backIconSize = 24.0;
  static const _avatarMaxSize = 90.0;
  static const _avatarMinSize = 36.0;
  static const _avatarTopMargin = 45.0;
  static const _titleTopMargin = _avatarMaxSize + _avatarTopMargin + 50;
  static const _subtitleTopMargin = _titleTopMargin + 31;
  static const _buttonTopMargin = _subtitleTopMargin + 40;
  static const _childFadeOffset = 0.1;

  _TransitionAppBarDelegate({
    required this.profileAvatar,
    required this.title,
    required this.extent,
    this.trailing,
    this.subtitle,
    this.child,
    this.onCameraTap,
  });

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => 62;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return title != oldDelegate.title || subtitle != oldDelegate.subtitle;
  }

  static final _avatarMarginTween = EdgeInsetsTween(
    begin: const EdgeInsets.only(top: _avatarTopMargin),
    end: const EdgeInsets.only(
      top: 12,
      left: _iconSideMargin + _backIconSize + 16,
    ),
  );

  static final _titleMarginTween = EdgeInsetsTween(
    begin: const EdgeInsets.only(top: _titleTopMargin),
    end: const EdgeInsets.only(
      top: 22,
      left: _iconSideMargin + _backIconSize + 60,
    ),
  );

  static final _avatarAlignTween = AlignmentTween(
    begin: Alignment.topCenter,
    end: Alignment.topLeft,
  );

  static final _titleAlignTween = AlignmentTween(
    begin: Alignment.topCenter,
    end: Alignment.topLeft,
  );

  static final _bottomBorderTween = BorderTween(
    begin: const Border(),
    end: const Border(
      bottom: BorderSide(
        color: AppColors.greyOutlineColor,
        width: 1.2,
      ),
    ),
  );

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final tempVal = 72 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;

    final avatarSize = (1 - progress) * _avatarMaxSize + _avatarMinSize;

    final avatarMargin = _avatarMarginTween.lerp(progress);
    final titleMargin = _titleMarginTween.lerp(progress);

    final avatarAlign = _avatarAlignTween.lerp(progress);
    final titleAlign = _titleAlignTween.lerp(progress);
    final bottomBorder = _bottomBorderTween.lerp(progress);
    final isChildVisible = progress < _childFadeOffset;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: bottomBorder,
        color: AppColors.lightBackgroundColor,
      ),
      child: Stack(
        children: <Widget>[
          // Back Button
          InkWell(
            onTap: AppRouter.pop,
            child: Padding(
              padding: const EdgeInsets.only(
                top: _iconTopMargin,
                left: _iconSideMargin,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.adaptive.arrow_back_rounded,
                  size: _backIconSize,
                ),
              ),
            ),
          ),

          // Avatar
          Padding(
            padding: avatarMargin,
            child: Align(
              alignment: avatarAlign,
              child: SizedBox(
                height: avatarSize,
                width: avatarSize,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 233, 233, 233),
                        ),
                        padding: const EdgeInsets.all(3),
                        child: profileAvatar,
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 0,
                      child: AnimatedSwitcher(
                        duration: Durations.fastest,
                        child: !isChildVisible
                            ? const SizedBox.shrink()
                            : InkWell(
                                onTap: onCameraTap,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: AppColors.buttonGradientPurple,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      size: 23,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Title
          Padding(
            padding: titleMargin,
            child: Align(
              alignment: titleAlign,
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.textBlackColor,
                  fontSize: 17 + (4 * (1 - progress)),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Subtitle
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: _subtitleTopMargin),
              child: Align(
                alignment: Alignment.topCenter,
                child: AnimatedSwitcher(
                  duration: Durations.fastest,
                  child: isChildVisible
                      ? Text(
                          subtitle!,
                          style: const TextStyle(
                            color: AppColors.textLightGreyColor,
                            fontSize: 18,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),

          // Buttons
          if (child != null)
            Padding(
              padding: const EdgeInsets.only(top: _buttonTopMargin),
              child: Align(
                alignment: Alignment.topCenter,
                child: AnimatedSwitcher(
                  duration: Durations.fastest,
                  child: isChildVisible ? child : const SizedBox.shrink(),
                ),
              ),
            ),

          // Icon
          if (trailing != null)
            Padding(
              padding: const EdgeInsets.only(
                top: _iconTopMargin,
                right: _iconSideMargin,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: trailing,
              ),
            ),
        ],
      ),
    );
  }
}
