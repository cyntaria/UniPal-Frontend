import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../auth/providers/auth_provider.dart';
import '../providers/students_provider.dart';

// Routing
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/typedefs.dart';

// Widgets
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_tab_bar.dart';
import '../widgets/student_connection_buttons.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otherStudent = ref.watch(
      studentsProvider.select((value) => value.otherStudent),
    );
    final currentStudent = ref.watch(
      studentsProvider.select((value) => value.currentStudent),
    );
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, _) {
              return <Widget>[
                // Profile Picture and Name
                ProfileAppBar(
                  extent: 330,
                  avatarUrl: otherStudent['profile_picture_url']! as String,
                  title:
                      "${otherStudent['first_name']} ${otherStudent['last_name']}",
                  subtitle: otherStudent['current_status']! as String,
                  trailing: InkWell(
                    onTap: () => ref.read(authProvider.notifier).logout(),
                    child: const Icon(
                      Icons.logout_rounded,
                      color: AppColors.redColor,
                    ),
                  ),
                  child: StudentConnectionButtons(
                    studentConnection:
                        otherStudent['student_connection'] as JSON?,
                    myErp: currentStudent['erp']! as String,
                    studentErp: otherStudent['erp']! as String,
                  ),
                ),

                // Tabs
                const ProfileTabBar(),
              ];
            },
            body: Center(
              child: GestureDetector(
                onTap: () => AppRouter.pushNamed(
                  Routes.UpdatePreferencesScreen,
                ),
                child: const Text('Update Preferences'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
