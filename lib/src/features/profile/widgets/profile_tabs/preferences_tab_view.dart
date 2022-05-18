import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../../auth/providers/auth_provider.dart';
import '../../providers/hobbies_provider.dart';
import '../../providers/interests_provider.dart';
import '../../providers/student_statuses_provider.dart';
import '../../providers/students_provider.dart';

// Routing
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';

// Models
import '../../models/hobby_model.codegen.dart';
import '../../models/interest_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';

// Widgets
import '../../../shared/widgets/custom_filter_chip.dart';
import '../../../shared/widgets/custom_text_button.dart';
import '../../../shared/widgets/labeled_widget.dart';

final _interestModelsProvider =
    Provider.family.autoDispose<List<InterestModel>?, List<int>?>(
  (ref, ids) {
    final interestsProv = ref.watch(interestsProvider);
    return ids?.map(interestsProv.getInterestById).toList();
  },
);

final _hobbyModelsProvider =
    Provider.family.autoDispose<List<HobbyModel>?, List<int>?>(
  (ref, ids) {
    final hobbiesProv = ref.watch(hobbiesProvider);
    return ids?.map(hobbiesProv.getHobbyById).toList();
  },
);

class PreferencesTabView extends HookConsumerWidget {
  const PreferencesTabView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final student = ref.watch(profileScreenStudentProvider)!;
    final currentStudent = ref.watch(currentStudentProvider)!;
    final hobbies = ref.watch(_hobbyModelsProvider(student.hobbies));
    final interests = ref.watch(_interestModelsProvider(student.interests));
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Fav Campus Activity
            LabeledWidget(
              label: 'Favourite Campus Activity',
              child: Text(
                student.favouriteCampusActivity ?? 'Not Specified',
              ),
            ),

            // Edit Preferences
            if (currentStudent.erp == student.erp)
              CustomTextButton.gradient(
                width: 60,
                height: 30,
                onPressed: () {
                  AppRouter.pushNamed(Routes.UpdatePreferencesScreenRoute);
                },
                gradient: AppColors.buttonGradientPurple,
                child: Center(
                  child: Text(
                    'Edit',
                    style: AppTypography.secondary.title18.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
          ],
        ),

        Insets.gapH20,

        // Fav Hangout Spot
        LabeledWidget(
          label: 'Favourite Campus Hangout Spot',
          child: Text(
            student.favouriteCampusHangoutSpot ?? 'Not Specified',
            style: AppTypography.primary.body14,
          ),
        ),

        Insets.gapH20,

        // Current Status
        Consumer(
          builder: (_, ref, __) {
            final currentStatus = student.currentStatusId == null
                ? 'Not Specified'
                : ref
                    .watch(
                      studentStatusByIdProvider(
                        student.currentStatusId!,
                      ),
                    )
                    .studentStatus;
            return LabeledWidget(
              label: 'Current Status',
              child: Text(
                currentStatus,
                style: AppTypography.primary.body14,
              ),
            );
          },
        ),

        Insets.gapH20,

        // Hobbies
        LabeledWidget(
          label: 'Top 3 Hobbies',
          child: Wrap(
            spacing: 8,
            children: [
              if (hobbies == null)
                Text(
                  'Not Specified',
                  style: AppTypography.primary.body14,
                )
              else ...[
                for (var hobby in hobbies)
                  CustomFilterChip<HobbyModel>(
                    value: hobby,
                    label: Text(hobby.hobby),
                  ),
              ]
            ],
          ),
        ),

        Insets.gapH20,

        // Interests
        LabeledWidget(
          label: 'Top 3 Interests',
          child: Wrap(
            spacing: 8,
            children: [
              if (interests == null)
                Text(
                  'Not Specified',
                  style: AppTypography.primary.body14,
                )
              else ...[
                for (var interest in interests)
                  CustomFilterChip<InterestModel>(
                    value: interest,
                    label: Text(interest.interest),
                  ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
