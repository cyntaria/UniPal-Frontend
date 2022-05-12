import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../../profile/models/student_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return AuthRepository(apiService: _apiService);
});

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  Future<StudentModel> sendLoginData({
    required JSON data,
    required void Function(String newToken) updateTokenCallback,
  }) async {
    return _apiService.setData<StudentModel>(
      endpoint: ApiEndpoint.auth(AuthEndpoint.LOGIN),
      data: data,
      requiresAuthToken: false,
      converter: (response) {
        updateTokenCallback(response.body['token'] as String);
        return StudentModel.fromJson(response.body);
      },
    );
  }

  Future<StudentModel> sendRegisterData({
    required JSON data,
    required void Function(String newToken) updateTokenCallback,
  }) async {
    return _apiService.setData<StudentModel>(
      endpoint: ApiEndpoint.auth(AuthEndpoint.REGISTER),
      data: data,
      requiresAuthToken: false,
      converter: (response) {
        updateTokenCallback(response.body['token'] as String);
        return StudentModel.fromJson(data);
      },
    );
  }

  Future<String> sendForgotPasswordData({
    required JSON data,
  }) async {
    return _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(AuthEndpoint.FORGOT_PW_SEND_OTP),
      data: data,
      requiresAuthToken: false,
      converter: (response) => response.headers.message,
    );
  }

  Future<String> sendResetPasswordData({
    required JSON data,
  }) async {
    return _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(AuthEndpoint.FORGOT_PW_RESET_PASSWORD),
      data: data,
      requiresAuthToken: false,
      converter: (response) => response.headers.message,
    );
  }

  Future<String> sendChangePasswordData({
    required JSON data,
  }) async {
    return _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(AuthEndpoint.CHANGE_PASSWORD),
      data: data,
      requiresAuthToken: false,
      converter: (response) => response.headers.message,
    );
  }

  Future<String> verifyOtpData({required JSON data}) async {
    return _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(AuthEndpoint.FORGOT_PW_VERIFY_OTP),
      data: data,
      requiresAuthToken: false,
      converter: (response) => response.headers.message,
    );
  }
}
