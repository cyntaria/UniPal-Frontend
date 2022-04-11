import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../auth/providers/auth_provider.dart';

// Screens
import '../auth/screens/login_screen.dart';
import '../profile/screens/preference_detail_fields.dart';

class AppStartupScreen extends HookConsumerWidget {
  const AppStartupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return authState.maybeWhen(
      authenticated: (fullName) => const UpdatePreferencesScreen(),
      orElse: () => const LoginScreen(),
    );
  }
}
