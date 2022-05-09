import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Services
import '../core/local/key_value_storage_service.dart';
import '../core/networking/api_endpoint.dart';
import '../core/networking/api_service.dart';
import '../core/networking/dio_service.dart';

// Interceptors
import '../core/networking/interceptors/api_interceptor.dart';
import '../core/networking/interceptors/logging_interceptor.dart';
import '../core/networking/interceptors/refresh_token_interceptor.dart';

final keyValueStorageServiceProvider = Provider<KeyValueStorageService>(
  (ref) => KeyValueStorageService(),
);

final _dioProvider = Provider<Dio>((ref) {
  final baseOptions = BaseOptions(
    baseUrl: ApiEndpoint.baseUrl,
  );
  return Dio(baseOptions);
});

final _dioServiceProvider = Provider<DioService>((ref) {
  final _dio = ref.watch(_dioProvider);
  return DioService(
    dioClient: _dio,
    httpClientAdapter: Http2Adapter(
      ConnectionManager(
        idleTimeout: 10000,
        onClientCreate: (_, config) {
          // Ignore bad certificate
          config.onBadCertificate = (_) => true;
        },
      ),
    ),
    interceptors: [
      // Order of interceptors very important
      ApiInterceptor(ref),
      if (kDebugMode) LoggingInterceptor(),
      RefreshTokenInterceptor(ref.read, dioClient: _dio)
    ],
  );
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final _dioService = ref.watch(_dioServiceProvider);
  return ApiService(_dioService);
});
