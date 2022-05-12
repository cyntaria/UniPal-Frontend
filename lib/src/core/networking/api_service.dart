import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

// Exceptions
import './custom_exception.dart';

// Services
import './api_interface.dart';
import './dio_service.dart';

// Helpers
import '../../helpers/typedefs.dart';

// Models
import 'response_model.dart';

/// A service class implementing methods for basic API requests.
class ApiService implements ApiInterface {
  /// An instance of [DioService] for network requests
  late final DioService _dioService;

  /// A public constructor that is used to initialize the API service
  /// and setup the underlying [_dioService].
  ApiService(DioService dioService) : _dioService = dioService;

  /// An implementation of the base method for requesting collection of data
  /// from the [endpoint].
  /// The response body must be a [List], else the [converter] fails.
  ///
  /// The [converter] callback is used to **deserialize** the response body
  /// into a [List] of objects of type [T].
  /// The callback is executed on each member of the response `body` List.
  /// [T] is usually set to a `Model`.
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  @override
  Future<List<T>> getCollectionData<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    CachePolicy? cachePolicy,
    int? cacheAgeDays,
    bool requiresAuthToken = true,
    required T Function(JSON responseBody) converter,
  }) async {
    List<JSON> body;

    try {
      // Entire map of response
      final data = await _dioService.get<List<JSON>>(
        endpoint: endpoint,
        cacheOptions: _dioService.globalCacheOptions?.copyWith(
          policy: cachePolicy,
          maxStale: cacheAgeDays != null
              ? Nullable(Duration(days: cacheAgeDays))
              : null,
        ),
        options: Options(
          headers: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        queryParams: queryParams,
        cancelToken: cancelToken,
      );

      // Items of table as json
      body = data.body;
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      // Returning the deserialized objects
      return body.map((dataMap) => converter(dataMap)).toList();
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  /// An implementation of the base method for requesting a document of data
  /// from the [endpoint].
  /// The response body must be a [Map], else the [converter] fails.
  ///
  /// The [converter] callback is used to **deserialize** the response body
  /// into an object of type [T].
  /// The callback is executed on the response `body`.
  /// [T] is usually set to a `Model`.
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  @override
  Future<T> getDocumentData<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    CachePolicy? cachePolicy,
    int? cacheAgeDays,
    bool requiresAuthToken = true,
    required T Function(JSON response) converter,
  }) async {
    JSON body;
    try {
      // Entire map of response
      final data = await _dioService.get<JSON>(
        endpoint: endpoint,
        queryParams: queryParams,
        cacheOptions: _dioService.globalCacheOptions?.copyWith(
          policy: cachePolicy,
          maxStale: cacheAgeDays != null
              ? Nullable(Duration(days: cacheAgeDays))
              : null,
        ),
        options: Options(
          headers: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );

      body = data.body;
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      // Returning the deserialized object
      return converter(body);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  /// An implementation of the base method for inserting [data] at
  /// the [endpoint].
  /// The response body must be a [Map], else the [converter] fails.
  ///
  /// The [data] contains body for the request.
  ///
  /// The [converter] callback is used to **deserialize** the [ResponseModel]
  /// into an object of type [T].
  /// The callback is executed on the response.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  @override
  Future<T> setData<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(ResponseModel<JSON> response) converter,
  }) async {
    ResponseModel<JSON> response;

    try {
      // Entire map of response
      response = await _dioService.post<JSON>(
        endpoint: endpoint,
        data: data,
        options: Options(
          headers: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      // Returning the serialized object
      return converter(response);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  /// An implementation of the base method for updating [data]
  /// at the [endpoint].
  /// The response body must be a [Map], else the [converter] fails.
  ///
  /// The [data] contains body for the request.
  ///
  /// The [converter] callback is used to **deserialize** the [ResponseModel]
  /// into an object of type [T].
  /// The callback is executed on the response.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  @override
  Future<T> updateData<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(ResponseModel<JSON> response) converter,
  }) async {
    ResponseModel<JSON> response;

    try {
      // Entire map of response
      response = await _dioService.patch<JSON>(
        endpoint: endpoint,
        data: data,
        options: Options(
          headers: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      // Returning the serialized object
      return converter(response);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  /// An implementation of the base method for deleting [data]
  /// at the [endpoint].
  /// The response body must be a [Map], else the [converter] fails.
  ///
  /// The [data] contains body for the request.
  ///
  /// The [converter] callback is used to **deserialize** the [ResponseModel]
  /// into an object of type [T].
  /// The callback is executed on the response.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  @override
  Future<T> deleteData<T>({
    required String endpoint,
    JSON? data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(ResponseModel<JSON> response) converter,
  }) async {
    ResponseModel<JSON> response;

    try {
      // Entire map of response
      response = await _dioService.delete<JSON>(
        endpoint: endpoint,
        data: data,
        options: Options(
          headers: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      // Returning the serialized object
      return converter(response);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  /// An implementation of the base method for cancelling
  /// requests pre-maturely using the [cancelToken].
  ///
  /// If null, the **default** [cancelToken] inside [DioService] is used.
  @override
  void cancelRequests({CancelToken? cancelToken}) {
    _dioService.cancelRequests(cancelToken: cancelToken);
  }
}
