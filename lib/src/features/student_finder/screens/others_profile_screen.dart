import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../profile/models/student_model.codegen.dart';

// Providers
import '../../auth/providers/auth_provider.dart';
import '../providers/students_provider.dart';

// Helpers
import '../../../helpers/extensions/string_extension.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_colors.dart';

// Widgets
import '../../profile/widgets/profile_header/profile_app_bar.dart';
import '../../profile/widgets/profile_header/profile_tab_bar.dart';
import '../../profile/widgets/profile_tabs/about_tab_view.dart';
import '../../profile/widgets/profile_tabs/activities_tab_view.dart';
import '../../profile/widgets/profile_tabs/preferences_tab_view.dart';
import '../../shared/widgets/custom_network_image.dart';
import '../../shared/widgets/async_value_widget.dart';
import '../../shared/widgets/custom_circular_loader.dart';
import '../../shared/widgets/error_response_handler.dart';
import '../widgets/finder/connection_buttons.dart';

class OthersProfileScreen extends ConsumerWidget {
  final String erp;

  const OthersProfileScreen({
    super.key,
    required this.erp,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: SafeArea(
        child: AsyncValueWidget<StudentModel>(
          value: ref.watch(othersProfileFutureProvider(erp)),
          loading: () => const CustomCircularLoader(
            color: AppColors.primaryColor,
          ),
          error: (error, st) => ErrorResponseHandler(
            error: error,
            stackTrace: st,
            retryCallback: () => ref.refresh(othersProfileFutureProvider(erp)),
          ),
          data: (student) => DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, _) {
                return <Widget>[
                  // Profile Picture and Name
                  ProfileAppBar(
                    extent: 320,
                    title: '${student.firstName} ${student.lastName}',
                    subtitle: student.studentType.name.capitalize,
                    profileAvatar: CustomNetworkImage(
                      imageUrl: student.profilePictureUrl,
                      shape: BoxShape.circle,
                    ),
                    child: Consumer(
                      builder: (_, ref, __) {
                        final myErp = ref.watch(
                          currentStudentProvider.select((value) => value!.erp),
                        );
                        return ConnectionButtons(
                          myErp: myErp,
                          studentErp: student.erp,
                          studentConnection: student.studentConnection,
                        );
                      },
                    ),
                  ),

                  // Tabs
                  const ProfileTabBar(),

                  const SliverToBoxAdapter(
                    child: Insets.gapH25,
                  )
                ];
              },
              body: TabBarView(
                children: [
                  // About
                  PreferencesTabView(student: student),

                  // University
                  AboutTabView(student: student),

                  // Activities
                  const ActivitiesTabView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
