import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Service imports
import '../services/networking/api_endpoint.dart';
import '../services/networking/api_service.dart';
import '../services/networking/dio_service.dart';

//Interceptor imports
import '../services/networking/interceptors/api_interceptor.dart';
import '../services/networking/interceptors/logging_interceptor.dart';
import '../services/networking/interceptors/refresh_token_interceptor.dart';

final _dioProvider = Provider<Dio>((ref) {
  final baseOptions = BaseOptions(
    baseUrl: ApiEndpoint.baseUrl,
  );
  return Dio(baseOptions);
});

final _dioServiceProvider = Provider<DioService>((ref) {
  final _dio = ref.watch(_dioProvider);
  // Order of interceptors very important
  return DioService(
    dioClient: _dio,
    interceptors: [
      ApiInterceptor(ref),
      if (kDebugMode) LoggingInterceptor(),
      RefreshTokenInterceptor(dioClient: _dio, ref: ref)
    ],
  );
});

final _apiServiceProvider = Provider<ApiService>((ref) {
  final _dioService = ref.watch(_dioServiceProvider);
  return ApiService(_dioService);
});
