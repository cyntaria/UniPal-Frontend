import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../auth/providers/auth_provider.dart';
import '../posts/providers/reaction_types_provider.dart';
import '../profile/providers/campuses_provider.dart';
import '../profile/providers/hobbies_provider.dart';
import '../profile/providers/interests_provider.dart';
import '../profile/providers/programs_provider.dart';
import '../profile/providers/student_statuses_provider.dart';

// Widgets
import '../shared/widgets/custom_circular_loader.dart';
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
    ]);
  },
);

class AppStartupScreen extends ConsumerWidget {
  const AppStartupScreen({Key? key}) : super(key: key);

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
  const LottieAnimationLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomCircularLoader(color: Colors.purpleAccent),
    );
  }
}
