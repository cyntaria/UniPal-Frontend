import 'package:hooks_riverpod/hooks_riverpod.dart';

// Services
import '../../../core/local/key_value_storage_service.dart';

// Models
import '../../profile/models/student_model.codegen.dart';

// Providers
import '../../all_providers.dart';
import 'register_form_provider.dart';

// Repositories
import '../repositories/auth_repository.dart';

final currentStudentProvider = StateProvider<StudentModel?>((ref) => null);

final authProvider = StateNotifierProvider<AuthProvider, AsyncValue<bool>>(
  (ref) {
    final _authRepository = ref.watch(authRepositoryProvider);
    final _keyValueStorageService = ref.watch(keyValueStorageServiceProvider);
    return AuthProvider(
      ref,
      authRepository: _authRepository,
      keyValueStorageService: _keyValueStorageService,
    );
  },
);

class AuthProvider extends StateNotifier<AsyncValue<bool>> {
  final AuthRepository _authRepository;
  final KeyValueStorageService _keyValueStorageService;
  final Ref _ref;

  AuthProvider(
    this._ref, {
    required AuthRepository authRepository,
    required KeyValueStorageService keyValueStorageService,
  })  : _authRepository = authRepository,
        _keyValueStorageService = keyValueStorageService,
        super(const AsyncValue.data(false)) {
    init();
  }

  Future<void> init() async {
    final student = _keyValueStorageService.getAuthUser();
    final password = await _keyValueStorageService.getAuthPassword();
    if (student == null || password.isEmpty) {
      logout();
    } else {
      _ref.read(currentStudentProvider.notifier).state = student;
      state = const AsyncValue.data(true);
    }
  }

  void _cacheAuthProfile(StudentModel student, String password) {
    _keyValueStorageService
      ..setAuthUser(student)
      ..setAuthPassword(password);
  }

  void _cacheAuthToken(String value) {
    _keyValueStorageService.setAuthToken(value);
  }

  Future<void> register({
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final data = _ref
        .read(
          registerFormProvider.notifier,
        )
        .savedFormStudent!
        .toJson();
    data['password'] = password;

    state = await AsyncValue.guard(() async {
      final student = await _authRepository.sendRegisterData(
        data: data,
        updateTokenCallback: _cacheAuthToken,
      );

      // Update current user in memory
      _ref.read(currentStudentProvider.notifier).state = student;

      // Save authentication details in cache
      _cacheAuthProfile(student, password);

      return true;
    });
  }

  Future<void> login({
    required String erp,
    required String password,
  }) async {
    final data = {'erp': erp, 'password': password};

    state = await AsyncValue.guard(() async {
      final student = await _authRepository.sendLoginData(
        data: data,
        updateTokenCallback: _cacheAuthToken,
      );

      // Update current user in memory
      _ref.read(currentStudentProvider.notifier).state = student;

      // Save authentication details in cache
      _cacheAuthProfile(student, password);

      return true;
    });
  }

  void logout() {
    _keyValueStorageService.resetKeys();
    state = const AsyncValue.data(false);
    _ref.invalidate(currentStudentProvider);
  }
}
