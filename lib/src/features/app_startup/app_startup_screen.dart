import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

// Providers
import '../auth/providers/auth_provider.dart';
import '../posts/providers/reaction_types_provider.dart';
import '../profile/providers/campuses_provider.dart';
import '../profile/providers/hobbies_provider.dart';
import '../profile/providers/interests_provider.dart';
import '../profile/providers/programs_provider.dart';
import '../profile/providers/student_statuses_provider.dart';
import '../activities/providers/campus_spots_provider.dart';

//Helpers
import '../../helpers/constants/app_utils.dart';
import '../../helpers/constants/lottie_assets.dart';
import '../../helpers/extensions/context_extensions.dart';

// Widgets
import '../shared/widgets/error_response_handler.dart';
import 'auth_widget_builder.dart';

final _cacheLoaderFutureProvider = FutureProvider.autoDispose<void>(
  (ref) async {
    await Future.wait([
      ref.watch(authProvider.notifier).loadUserAuthDataInMemory(),
      ref.watch(interestsProvider).loadInterestsInMemory(),
      ref.watch(hobbiesProvider).loadHobbiesInMemory(),
      ref.watch(campusesProvider).loadCampusesInMemory(),
      ref.watch(programsProvider).loadProgramsInMemory(),
      ref.watch(studentStatusesProvider).loadStudentStatusesInMemory(),
      ref.watch(reactionTypesProvider).loadReactionTypesInMemory(),
      ref.watch(campusSpotsProvider).loadCampusSpotsInMemory(),
    ]);
  },
);

class AppStartupScreen extends ConsumerWidget {
  const AppStartupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheLoaderFuture = ref.watch(_cacheLoaderFutureProvider);
    return cacheLoaderFuture.when(
      data: (_) => const AuthWidgetBuilder(),
      loading: () => const LottieAnimationLoader(),
      error: (error, st) => Scaffold(
        body: ErrorResponseHandler(
          error: error,
          retryCallback: () => ref.refresh(_cacheLoaderFutureProvider),
          stackTrace: st,
        ),
      ),
    );
  }
}

class LottieAnimationLoader extends StatelessWidget {
  const LottieAnimationLoader({super.key});

  @override
  Widget build(BuildContext context) {
    const loaders = [
      LottieAssets.femaleWalkingLottie,
      LottieAssets.movingBusLottie,
      LottieAssets.peopleTalkingLottie,
    ];
    final i = AppUtils.randomizer().nextInt(3);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          loaders[i],
          width: context.screenWidth,
        ),
      ),
    );
  }
}
