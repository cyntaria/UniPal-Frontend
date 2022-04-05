import 'package:hooks_riverpod/hooks_riverpod.dart';

// States
import '../states/auth_state.codegen.dart';
import '../states/registration_state.codegen.dart';

final registerStateProvider = StateProvider<RegistrationState>((ref) {
  return const RegistrationState.personal();
});

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  // final _authRepository = ref.watch(_authRepositoryProvider);
  // final _keyValueStorageService = ref.watch(keyValueStorageServiceProvider);
  return AuthProvider(
    ref: ref,
    // authRepository: _authRepository,
    // keyValueStorageService: _keyValueStorageService,
  );
});

class AuthProvider extends StateNotifier<AuthState> {
  final Map<String, Object?> _currentUser = {
    'erp': '',
    'firstName': '',
    'lastName': '',
    'contact': '',
    'email': '',
    'birthday': null,
    'uniEmail': '',
    'gradYear': '',
    'program': '',
    'campus': '',
    'password': '',
    'role': 'student',
  };
  final Ref _ref;

  AuthProvider({
    required Ref ref,
  })  : _ref = ref,
        super(const AuthState.unauthenticated()) {
    init();
  }

  void init() {}

  void savePersonalDetails({
    required String erp,
    required String firstName,
    required String lastName,
    required String contact,
    required String email,
    required DateTime birthday,
  }) {
    // Change to loading
    state = const AuthState.authenticating();

    // Save details
    _currentUser['erp'] = erp;
    _currentUser['firstName'] = firstName;
    _currentUser['lastName'] = lastName;
    if (contact.startsWith('0')) {
      _currentUser['contact'] = '+92${contact.substring(1)}';
    } else {
      _currentUser['contact'] = contact;
    }
    _currentUser['email'] = email;
    _currentUser['birthday'] = birthday;

    // Stop loading and move to university form
    state = const AuthState.unauthenticated();
    _ref.read(registerStateProvider.state).update(
          (state) => const RegistrationState.university(),
        );
  }

  void saveUniversityDetails({
    required String uniEmail,
    required DateTime gradYear,
    required String program,
    required String campus,
  }) {
    // Change to loading
    state = const AuthState.authenticating();

    // Save details
    _currentUser['uniEmail'] = uniEmail;
    _currentUser['gradYear'] = gradYear;
    _currentUser['program'] = program;
    _currentUser['campus'] = campus;

    // Stop loading and move to password form
    state = const AuthState.unauthenticated();
    _ref.read(registerStateProvider.state).update(
          (state) => const RegistrationState.password(),
        );
  }

  Future<void> register({
    required String password,
  }) async {
    state = const AuthState.authenticating();
    _savePassword(password);

    // TODO(arafaysaleem): replace with actual authentication code
    state = const AuthState.authenticated(fullName: 'DONE!!');
  }

  void _savePassword(String password) {
    _currentUser['password'] = password;
  }
}
