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

// States
import '../../shared/states/future_state.codegen.dart';

final currentStudentProvider = StateProvider<StudentModel?>((ref) => null);

final authProvider = StateNotifierProvider<AuthProvider, FutureState<bool?>>(
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

class AuthProvider extends StateNotifier<FutureState<bool?>> {
  final AuthRepository _authRepository;
  final KeyValueStorageService _keyValueStorageService;
  final Ref _ref;

  AuthProvider(
    this._ref, {
    required AuthRepository authRepository,
    required KeyValueStorageService keyValueStorageService,
  })  : _authRepository = authRepository,
        _keyValueStorageService = keyValueStorageService,
        super(const FutureState.idle());

  Future<void> loadUserAuthDataInMemory() async {
    final student = _keyValueStorageService.getAuthUser();
    final password = await _keyValueStorageService.getAuthPassword();
    if (student != null && password.isNotEmpty) {
      _ref.read(currentStudentProvider.notifier).state = student;
      state = const FutureState.data(data: true);
    }
  }

  void cacheAuthProfile(StudentModel student) {
    _keyValueStorageService.setAuthUser(student);
  }

  void _cacheAuthPassword(String password) {
    _keyValueStorageService.setAuthPassword(password);
  }

  void _cacheAuthToken(String value) {
    _keyValueStorageService.setAuthToken(value);
  }

  Future<void> register({
    required String password,
  }) async {
    state = const FutureState.loading();

    final registerFormProv = _ref.read(
      registerFormProvider.notifier,
    );
    final personalData = registerFormProv.savedPersonalDetails!;
    final uniData = registerFormProv.savedUniversityDetails!;

    final data = StudentModel(
      erp: personalData.erp,
      firstName: personalData.firstName,
      lastName: personalData.lastName,
      gender: personalData.gender,
      uniEmail: personalData.uniEmail,
      contact: personalData.contact.startsWith('0')
          ? '+92${personalData.contact.substring(1)}'
          : personalData.contact,
      birthday: personalData.birthday,
      profilePictureUrl: 'https://avatars.githubusercontent.com/u/62943972?v=4',
      graduationYear: uniData.gradYear,
      programId: uniData.programId,
      campusId: uniData.campusId,
      isActive: true,
    ).toJson();
    data['password'] = password;

    state = await FutureState.makeGuardedRequest(() async {
      final student = await _authRepository.sendRegisterData(
        data: data,
        updateTokenCallback: _cacheAuthToken,
      );

      // Update current user in memory
      _ref.read(currentStudentProvider.notifier).state = student;

      // Save authentication details in cache
      cacheAuthProfile(student);
      _cacheAuthPassword(password);

      return true;
    });
  }

  Future<void> login({
    required String erp,
    required String password,
  }) async {
    state = const FutureState.loading();

    final data = {'erp': erp, 'password': password};

    state = await FutureState.makeGuardedRequest(() async {
      final student = await _authRepository.sendLoginData(
        data: data,
        updateTokenCallback: _cacheAuthToken,
      );

      // Update current user in memory
      _ref.read(currentStudentProvider.notifier).state = student;

      // Save authentication details in cache
      cacheAuthProfile(student);
      _cacheAuthPassword(password);

      return true;
    });
  }

  void logout() {
    _keyValueStorageService.resetKeys();
    state = const FutureState.idle();
    _ref.invalidate(currentStudentProvider);
  }
}
