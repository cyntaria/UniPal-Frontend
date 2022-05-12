// Helpers
import '../../helpers/constants/app_utils.dart';
import '../../helpers/typedefs.dart';

class ResponseModel<T> {
  final _ResponseHeadersModel headers;
  final T body;

  const ResponseModel({
    required this.headers,
    required this.body,
  });

  factory ResponseModel.fromJson(JSON json) {
    return ResponseModel(
      headers: _ResponseHeadersModel.fromJson(
        json['headers'] as JSON,
      ),
      body: json['body'] as T,
    );
  }
}

class _ResponseHeadersModel {
  final bool error;
  final String message;
  final String? code;

  const _ResponseHeadersModel({
    required this.error,
    required this.message,
    this.code,
  });

  factory _ResponseHeadersModel.fromJson(JSON json) {
    return _ResponseHeadersModel(
      error: AppUtils.boolFromInt(json['error'] as int),
      message: json['message'] as String,
      code: json['code'] as String?,
    );
  }
}
