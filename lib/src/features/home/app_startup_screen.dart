import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//routes
import '../auth/login_screen.dart';
import 'home_screen.dart';

class AppStartupScreen extends HookConsumerWidget {
  const AppStartupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const authState = true;
    return authState ? const HomeScreen() : const LoginScreen();
  }
}
