import 'dart:convert';

// Services
import 'key_value_storage_base.dart';

// Models
import '../../features/profile/models/student_model.codegen.dart';

// Helpers
import '../../helpers/typedefs.dart';

/// A service class for providing methods to store and retrieve key-value data
/// from common or secure storage.
class KeyValueStorageService {
  /// The name of auth token key
  static const _authTokenKey = 'authToken';

  /// The name of user password key
  static const _authPasswordKey = 'authPasswordKey';

  /// The name of user model key
  static const _authUserKey = 'authUserKey';

  /// Instance of key-value storage base class
  final _keyValueStorage = KeyValueStorageBase();

  /// Returns logged in user password
  Future<String> getAuthPassword() async {
    return await _keyValueStorage.getEncrypted(_authPasswordKey) ?? '';
  }

  /// Returns last authenticated user
  StudentModel? getAuthUser() {
    final user = _keyValueStorage.getCommon<String>(_authUserKey);
    if (user == null) return null;
    return StudentModel.fromJson(jsonDecode(user) as JSON);
  }

  /// Returns last authentication token
  Future<String> getAuthToken() async {
    return await _keyValueStorage.getEncrypted(_authTokenKey) ?? '';
  }

  /// Sets the authentication password to this value. Even though this method is
  /// asynchronous, we don't care about it's completion which is why we don't
  /// use `await` and let it execute in the background.
  void setAuthPassword(String password) {
    _keyValueStorage.setEncrypted(_authPasswordKey, password);
  }

  /// Sets the authenticated user to this value. Even though this method is
  /// asynchronous, we don't care about it's completion which is why we don't
  /// use `await` and let it execute in the background.
  void setAuthUser(StudentModel user) {
    _keyValueStorage.setCommon<String>(_authUserKey, jsonEncode(user.toJson()));
  }

  /// Sets the authentication token to this value. Even though this method is
  /// asynchronous, we don't care about it's completion which is why we don't
  /// use `await` and let it execute in the background.
  void setAuthToken(String token) {
    _keyValueStorage.setEncrypted(_authTokenKey, token);
  }

  /// Resets the authentication. Even though these methods are asynchronous, we
  /// don't care about their completion which is why we don't use `await` and
  /// let them execute in the background.
  void resetKeys() {
    _keyValueStorage
      ..clearCommon()
      ..clearEncrypted();
  }
}
