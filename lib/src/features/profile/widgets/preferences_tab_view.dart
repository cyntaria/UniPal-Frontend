import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/hobbies_provider.dart';
import '../providers/interests_provider.dart';
import '../providers/students_provider.dart';

// Routing
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';

// Models
import '../models/hobby_model.codegen.dart';
import '../models/interest_model.codegen.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

// Widgets
import '../../shared/widgets/custom_filter_chip.dart';
import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/labeled_widget.dart';

class PreferencesTabView extends HookConsumerWidget {
  const PreferencesTabView({Key? key}) : super(key: key);

  List<InterestModel> getInterestModels(WidgetRef ref, Set<int> ids) {
    final interestsProv = ref.watch(interestsProvider);
    return ids.map(interestsProv.getInterestById).toList();
  }

  List<HobbyModel> getHobbyModels(WidgetRef ref, Set<int> ids) {
    final hobbiesProv = ref.watch(hobbiesProvider);
    return ids.map(hobbiesProv.getHobbyById).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStudent = ref.watch(
      studentsProvider.select((value) {
        return value.currentStudent;
      }),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Fav Campus Activity
              LabeledWidget(
                label: 'Favourite Campus Activity',
                child: Text(
                  currentStudent['favourite_campus_activity']! as String,
                ),
              ),

              // Edit Preferences
              CustomTextButton.gradient(
                width: 60,
                height: 30,
                onPressed: () {
                  AppRouter.pushNamed(Routes.UpdatePreferencesScreen);
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
              currentStudent['favourite_campus_hangout_spot']! as String,
              style: AppTypography.primary.body14.copyWith(
                color: AppColors.textBlackColor,
              ),
            ),
          ),

          Insets.gapH20,

          // Hobbies
          LabeledWidget(
            label: 'Top 3 Hobbies',
            child: Wrap(
              spacing: 8,
              children: [
                for (var hobby in getHobbyModels(
                  ref,
                  currentStudent['hobbies']! as Set<int>,
                ))
                  CustomFilterChip<HobbyModel>(
                    value: hobby,
                    label: Text(hobby.hobby),
                  ),
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
                for (var interest in getInterestModels(
                  ref,
                  currentStudent['interests']! as Set<int>,
                ))
                  CustomFilterChip<InterestModel>(
                    value: interest,
                    label: Text(interest.interest),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
