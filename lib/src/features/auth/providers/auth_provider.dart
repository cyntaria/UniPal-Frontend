import 'package:hooks_riverpod/hooks_riverpod.dart';

// States
import '../states/registration_state.codegen.dart';

final registerStateProvider = StateProvider<RegistrationState>((ref) {
  return const RegistrationState.personal();
});
