import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/student_status_model.codegen.dart';

// Providers
import '../providers/preferences_provider.dart';

// States
import '../../shared/states/future_state.codegen.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

// Routing
import '../../../config/routes/app_router.dart';

// Widgets
import '../../shared/widgets/labeled_widget.dart';
import '../../shared/widgets/custom_dialog.dart';
import '../../shared/widgets/custom_dropdown_field.dart';
import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/custom_textfield.dart';
import '../../shared/widgets/scrollable_column.dart';
import '../../shared/widgets/custom_circular_loader.dart';
import '../providers/student_statuses_provider.dart';
import '../widgets/update_preferences/hobbies_filter_chips.dart';
import '../widgets/update_preferences/interests_filter_chips.dart';

class UpdatePreferencesScreen extends HookConsumerWidget {
  const UpdatePreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final prefsProv = ref.watch(prefsProvider.notifier);
    final favHangoutSpotController = useTextEditingController(
      text: prefsProv.favCampusHangoutSpot,
    );
    final favActivityController = useTextEditingController(
      text: prefsProv.favCampusActivity,
    );
    final currentStatusController = useTextEditingController(
      text: prefsProv.currentStatusId == null
          ? null
          : ref
              .watch(studentStatusByIdProvider(prefsProv.currentStatusId!))
              .studentStatus,
    );

    Future<bool> _showConfirmDialog() async {
      final doPop = await showDialog<bool>(
        context: context,
        barrierColor: AppColors.barrierColor,
        builder: (ctx) => const CustomDialog.confirm(
          title: 'Are you sure?',
          body: 'Do you want to go back without saving your preferences?',
          trueButtonText: 'Yes',
          falseButtonText: 'No',
        ),
      );
      if (doPop == null || !doPop) return Future<bool>.value(false);
      ref.read(prefsProvider.notifier).clearUnUpdatedPrefs();
      return Future<bool>.value(true);
    }

    void _updatePrefs() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        ref.read(prefsProvider.notifier).updatePreferences(
              newCampusHangoutSpot: favHangoutSpotController.text.isEmpty
                  ? null
                  : favHangoutSpotController.text,
              newCampusActivity: favActivityController.text.isEmpty
                  ? null
                  : favActivityController.text,
            );
      }
    }

    ref.listen<FutureState<String>>(
      prefsProvider,
      (_, state) async => state.whenOrNull(
        data: (message) async {
          favActivityController.clear();
          favHangoutSpotController.clear();
          return CustomDialog.showAlertDialog(
            context: context,
            dialogTitle: 'Update Preferences Success',
            reason: message,
            buttonText: 'Okay',
            onButtonPressed: AppRouter.pop,
          );
        },
        failed: (reason) async => CustomDialog.showAlertDialog(
          context: context,
          dialogTitle: 'Update Preferences Failed',
          reason: reason,
          buttonText: 'Okay',
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: AppBar(
        title: const Text('Update Preferences'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: formKey,
          onWillPop: _showConfirmDialog,
          child: ScrollableColumn(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Insets.gapH20,

              // Hobby Chips
              LabeledWidget(
                label: 'Hobbies',
                labelStyle: AppTypography.primary.subHeading16,
                child: const HobbiesFilterChips(),
              ),

              Insets.gapH20,

              // Interests
              LabeledWidget(
                label: 'Interests',
                labelStyle: AppTypography.primary.subHeading16,
                child: const InterestsFilterChips(),
              ),

              Insets.gapH20,

              // Current Status
              Consumer(
                builder: (_, ref, __) {
                  final statuses = ref
                      .watch(studentStatusesProvider)
                      .getAllStudentStatuses();
                  return LabeledWidget(
                    label: 'Current Status',
                    labelStyle: AppTypography.primary.body16,
                    child: CustomDropdownField<StudentStatusModel>.animated(
                      controller: currentStatusController,
                      hintStyle: AppTypography.primary.body16.copyWith(
                        color: AppColors.textGreyColor,
                      ),
                      hintText: 'Select a student status',
                      items: {for (var e in statuses) e.studentStatus: e},
                      onSelected: (studentStatus) {
                        ref.read(prefsProvider.notifier).selectStudentStatus(
                              studentStatus?.studentStatusId,
                            );
                      },
                    ),
                  );
                },
              ),

              Insets.gapH20,

              // Favorite Hangout Spot
              CustomTextField(
                controller: favHangoutSpotController,
                floatingText: 'Favorite Campus Spot',
                hintText: 'Type in your fav. hangout spot',
                keyboardType: TextInputType.text,
                maxLength: 45,
                textInputAction: TextInputAction.done,
              ),

              Insets.gapH25,

              // Favorite Activity
              CustomTextField(
                controller: favActivityController,
                floatingText: 'Favorite Campus Activity',
                hintText: 'Type in your fav. campus activity',
                keyboardType: TextInputType.text,
                maxLength: 45,
                textInputAction: TextInputAction.done,
              ),

              Insets.expand,

              // Confirm Details Button
              CustomTextButton.gradient(
                width: double.infinity,
                onPressed: _updatePrefs,
                gradient: AppColors.buttonGradientPurple,
                child: Consumer(
                  builder: (context, ref, child) {
                    final futureState = ref.watch(prefsProvider);
                    return futureState.maybeWhen(
                      loading: () => const CustomCircularLoader(
                        color: Colors.white,
                      ),
                      orElse: () => child!,
                    );
                  },
                  child: Center(
                    child: Text(
                      'UPDATE',
                      style: AppTypography.secondary.body16.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
