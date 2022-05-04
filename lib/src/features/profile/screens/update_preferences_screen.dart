import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../shared/widgets/labeled_widget.dart';
import '../providers/preferences_provider.dart';

// Routing
import '../../../config/routes/app_router.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

// Widgets
import '../../shared/widgets/custom_dialog.dart';
import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/custom_textfield.dart';
import '../../shared/widgets/scrollable_column.dart';
import '../widgets/update_preferences/hobbies_filter_chips.dart';
import '../widgets/update_preferences/interests_filter_chips.dart';

class UpdatePreferencesScreen extends StatefulHookConsumerWidget {
  const UpdatePreferencesScreen({Key? key}) : super(key: key);

  @override
  _UpdatePreferencesScreenState createState() =>
      _UpdatePreferencesScreenState();
}

class _UpdatePreferencesScreenState
    extends ConsumerState<UpdatePreferencesScreen> {
  late final formKey = GlobalKey<FormState>();

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
    ref.read(prefsProvider).clearUnupdatedPrefs();
    return Future<bool>.value(true);
  }

  void _onUpdate({
    required String favCampusSpot,
    required String favActivity,
  }) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ref.read(prefsProvider).updatePreferences(
            newCampusHangoutSpot: favCampusSpot,
            newCampusActivity: favActivity,
          );
      AppRouter.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final prefsProv = ref.watch(prefsProvider);
    final favHangoutSpotController = useTextEditingController(
      text: prefsProv.favCampusHangoutSpot,
    );
    final favActivityController = useTextEditingController(
      text: prefsProv.favCampusActivity,
    );

    return Scaffold(
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
                onPressed: () => _onUpdate(
                  favCampusSpot: favHangoutSpotController.text,
                  favActivity: favActivityController.text,
                ),
                gradient: AppColors.buttonGradientPurple,
                child: Consumer(
                  builder: (context, ref, child) {
                    return child!;
                    // final authState = ref.watch(authProvider);
                    // return authState.maybeWhen(
                    //   authenticating: () => const Center(
                    //     child: SpinKitRing(
                    //       color: Colors.white,
                    //       size: 30,
                    //       lineWidth: 4,
                    //       duration: Duration(milliseconds: 1100),
                    //     ),
                    //   ),
                    //   orElse: () => child!,
                    // );
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
