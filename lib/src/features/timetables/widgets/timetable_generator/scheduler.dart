import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../models/generated_timetable_model.codegen.dart';

// Providers
import '../../providers/scheduler_provider.dart';
import '../../providers/terms_provider.dart';
import '../../providers/timeslots_provider.dart';

// Helpers
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';

// Routing
import '../../../../config/routes/app_router.dart';

// Screens
import '../../screens/generated_timetables_screen.dart';

// Widgets
import 'add_class_link.dart';
import 'classes_selector_item.dart';
import '../../../shared/widgets/custom_text_button.dart';
import '../../../shared/widgets/error_response_handler.dart';
import '../../../shared/widgets/lottie_animation_loader.dart';

final _cacheLoaderFutureProvider = FutureProvider.autoDispose<void>(
  (ref) async {
    await Future.wait([
      ref.watch(schedulerProvider).loadAllClassesInMemory(),
      ref.watch(timeslotsProvider).loadTimeslotsInMemory(),
      ref.watch(termsProvider).loadTermsInMemory(),
    ]);
  },
);

class Scheduler extends ConsumerWidget {
  const Scheduler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheLoaderFuture = ref.watch(_cacheLoaderFutureProvider);
    return cacheLoaderFuture.when(
      loading: () => const LottieAnimationLoader(),
      error: (error, st) => Scaffold(
        body: ErrorResponseHandler(
          error: error,
          retryCallback: () => ref.refresh(_cacheLoaderFutureProvider),
          stackTrace: st,
        ),
      ),
      data: (_) {
        final selectedClasses = ref.watch(selectedClassesProvider);
        return Scaffold(
          body: ListView.separated(
            padding: const EdgeInsets.only(top: 15),
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemCount: selectedClasses.length,
            separatorBuilder: (_, i) => Insets.gapH15,
            itemBuilder: (_, i) {
              if (i != (selectedClasses.length - 1)) {
                return ClassesSelectorItem(index: i);
              }
              return Column(
                children: [
                  ClassesSelectorItem(index: i),

                  Insets.gapH10,

                  // Add Classes Button
                  const AddClassLink(),

                  const SizedBox(height: 60),
                ],
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomTextButton.gradient(
              width: double.infinity,
              gradient: AppColors.buttonGradientPurple,
              onPressed: () {
                AppRouter.push(
                  GeneratedTimetablesScreen(
                    generatedTimetableModel: GeneratedTimetableModel(
                      noOfSubjects: selectedClasses.length,
                      classes: selectedClasses,
                    ),
                  ),
                );
              },
              child: Center(
                child: Text(
                  'GENERATE',
                  style: AppTypography.secondary.body16.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
