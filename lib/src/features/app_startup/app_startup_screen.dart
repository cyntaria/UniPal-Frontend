import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../auth/providers/auth_provider.dart';

// Screens
import '../home/screens/home_screen.dart';
import 'welcome_screen.dart';

class AppStartupScreen extends HookConsumerWidget {
  const AppStartupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return authState.maybeWhen(
      data: (_) => const HomeScreen(),
      orElse: () => const WelcomeScreen(),
    );
  }
}
