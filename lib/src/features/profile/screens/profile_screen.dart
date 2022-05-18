import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';

// Providers
import '../../auth/providers/auth_provider.dart';
import '../providers/students_provider.dart';

// Helpers
import '../../../helpers/extensions/string_extension.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_colors.dart';

// Widgets
import '../widgets/profile_header/profile_app_bar.dart';
import '../widgets/profile_header/profile_tab_bar.dart';
import '../widgets/profile_header/student_connection_buttons.dart';
import '../widgets/profile_tabs/about_tab_view.dart';
import '../widgets/profile_tabs/activities_tab_view.dart';
import '../widgets/profile_tabs/preferences_tab_view.dart';

class ProfileScreen extends HookConsumerWidget {

  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStudent = ref.watch(currentStudentProvider)!;
    final student = ref.watch(profileScreenStudentProvider)!;
    final isMyProfile = currentStudent.erp == student.erp;

    Future<void> _openImagePickerScreen() async {
      final filePath = await AppRouter.pushNamed(
        Routes.MultiMediaPickerScreenRoute,
      ) as String?;
      if (filePath != null) {
        await ref.read(studentsProvider).updateProfilePicture(filePath);
      }
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
                  extent: isMyProfile ? 270 : 320,
                  avatarUrl: student.profilePictureUrl,
                  title: '${student.firstName} ${student.lastName}',
                  subtitle: student.studentType.name.capitalize,
                  onCameraTap: _openImagePickerScreen,
                  child: isMyProfile
                      ? null
                      : StudentConnectionButtons(
                          myErp: currentStudent.erp,
                          studentConnection: null,
                          studentErp: student.erp,
                        ),
                ),

                // Tabs
                const ProfileTabBar(),

                const SliverToBoxAdapter(
                  child: Insets.gapH25,
                )
              ];
            },
            body: const TabBarView(
              children: [
                // About
                PreferencesTabView(),

                // University
                AboutTabView(),

                // Activities
                ActivitiesTabView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
