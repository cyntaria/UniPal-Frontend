import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../../config/routes/app_router.dart';

// Providers
import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';

// Helpers
import '../../../helpers/extensions/string_extension.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_colors.dart';

// Screens
import '../../auth/screens/profile_picture_picker_screen.dart';

// Widgets
import '../../shared/widgets/custom_network_image.dart';
import '../widgets/profile_header/profile_app_bar.dart';
import '../widgets/profile_header/profile_tab_bar.dart';
import '../widgets/profile_tabs/about_tab_view.dart';
import '../widgets/profile_tabs/friends_tab_view.dart';
import '../widgets/profile_tabs/preferences_tab_view.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStudent = ref.watch(currentStudentProvider)!;

    void _saveNewProfilePicture(String filePath) {
      ref.read(profileProvider.notifier).updateProfilePicture(filePath);
    }

    void _openImagePickerScreen() {
      AppRouter.push(
        ProfilePicturePickerScreen(
          onSaveCallback: _saveNewProfilePicture,
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, _) {
              return <Widget>[
                // Profile Picture and Name
                ProfileAppBar(
                  extent: 270,
                  title:
                      '${currentStudent.firstName} ${currentStudent.lastName}',
                  subtitle: currentStudent.studentType.name.capitalize,
                  onCameraTap: _openImagePickerScreen,
                  profileAvatar: CustomNetworkImage(
                    imageUrl: currentStudent.profilePictureUrl,
                    shape: BoxShape.circle,
                  ),
                ),

                // Tabs
                const ProfileTabBar(
                  tabNames: ['PREFERENCES', 'ABOUT', 'FRIENDS'],
                ),

                const SliverToBoxAdapter(
                  child: Insets.gapH25,
                )
              ];
            },
            body: TabBarView(
              children: [
                // About
                PreferencesTabView(student: currentStudent),

                // University
                AboutTabView(student: currentStudent),

                // Activities
                FriendsTabView(erp: currentStudent.erp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
