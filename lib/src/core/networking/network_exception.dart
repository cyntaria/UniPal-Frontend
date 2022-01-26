// ignore_for_file: non_constant_identifier_names
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

//Helpers
import '../../helper/utils/exception_constants.dart';

part 'network_exception.freezed.dart';

/// An enum that holds names for our custom exceptions.
enum _ExceptionType {
    /// The exception for an expired bearer token.
    TokenExpiredException,

    /// The exception for a prematurely cancelled request.
    CancelException,

    /// The exception for a failed connection attempt.
    ConnectTimeoutException,

    /// The exception for failing to send a request.
    SendTimeoutException,

    /// The exception for failing to receive a response.
    ReceiveTimeoutException,

    /// The exception for no internet connectivity.
    SocketException,

    /// A better name for the socket exception.
    FetchDataException,

    /// The exception for an incorrect parameter in a request/response.
    FormatException,

    /// The exception for an unknown type of failure.
    UnrecognizedException,

    /// The exception for an unknown exception from the api.
    ApiException,
}

class NetworkException {
  final String name, message;
  final _ExceptionType exceptionType;

  const NetworkException({
    String? name,
    required this.message,
    required this.exceptionType
  }) : name = name ?? exceptionType.name;

  static NetworkException getDioException(Exception error) {
    try {
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.cancel:
            return const NetworkException(
              exceptionType: _ExceptionType.CancelException,
              message: 'Request cancelled prematurely',
            );
          case DioErrorType.connectTimeout:
            return const NetworkException(
              exceptionType: _ExceptionType.ConnectTimeoutException, 
              message: 'Connection not established',
            );
          case DioErrorType.sendTimeout:
            return const NetworkException(
              exceptionType: _ExceptionType.SendTimeoutException, 
              message: 'Failed to send',
            );
          case DioErrorType.receiveTimeout:
            return const NetworkException(
              exceptionType: _ExceptionType.ReceiveTimeoutException, 
              message: 'Failed to receive',
            );
          case DioErrorType.response:
          case DioErrorType.other:
            if(error.message.contains(_ExceptionType.SocketException.name)) {
              return const NetworkException(
                exceptionType: _ExceptionType.FetchDataException, 
                message: 'No internet connectivity',
              );
            }
            final name = error.response?.data['headers']['error'] as String;
            final message = error.response?.data['headers']['message'] as String;
            if (name == _ExceptionType.TokenExpiredException.name) {
                return NetworkException(
                  exceptionType: _ExceptionType.TokenExpiredException,
                  message: message,
                );
            }
            return NetworkException(
                exceptionType: _ExceptionType.ApiException,
                message: message,
            );
        }
      } else {
        return const NetworkException(
          exceptionType: _ExceptionType.UnrecognizedException, 
          message: 'Error unrecognized',
        );
      }
    } on FormatException catch (e) {
      return NetworkException(
        exceptionType: _ExceptionType.FormatException, 
        message: e.message,
      );
    } on Exception catch (_) {
      return const NetworkException(
        exceptionType: _ExceptionType.UnrecognizedException, 
        message: 'Error unrecognized',
      );
    }
  }
}
