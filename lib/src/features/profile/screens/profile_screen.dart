import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/student_model.codegen.dart';

// Providers
import '../../auth/providers/auth_provider.dart';
import '../providers/students_provider.dart';

// Helpers
import '../../../helpers/extensions/string_extension.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/typedefs.dart';

// Widgets
import '../widgets/profile_header/profile_app_bar.dart';
import '../widgets/profile_header/profile_tab_bar.dart';
import '../widgets/profile_header/student_connection_buttons.dart';
import '../widgets/profile_tabs/about_tab_view.dart';
import '../widgets/profile_tabs/activities_tab_view.dart';
import '../widgets/profile_tabs/preferences_tab_view.dart';

class ProfileScreen extends HookConsumerWidget {
  final StudentModel student;
  final bool isMyProfile;

  const ProfileScreen({
    Key? key,
    required this.student,
    required this.isMyProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otherStudent = ref.watch(
      studentsProvider.select((value) => value.otherStudent),
    );
    final currentStudent = ref.watch(currentStudentProvider);
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
                  child: isMyProfile
                      ? null
                      : StudentConnectionButtons(
                          myErp: currentStudent!.erp,
                          studentConnection:
                              otherStudent['student_connection'] as JSON?,
                          studentErp: otherStudent['erp']! as String,
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
