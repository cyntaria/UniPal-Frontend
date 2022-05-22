import 'package:freezed_annotation/freezed_annotation.dart';

// Networking
import '../../../core/networking/custom_exception.dart';

part 'future_state.codegen.freezed.dart';

@freezed
class FutureState<T> with _$FutureState<T> {
  const factory FutureState.idle() = IDLE;

  const factory FutureState.loading() = LOADING;

  const factory FutureState.data({required T data}) = DATA;

  const factory FutureState.failed({required String reason}) = FAILED;

  static Future<FutureState<T>> makeGuardedRequest<T>(
    Future<T> Function() callback, {
    String? errorMessage,
  }) async {
    try {
      final result = await callback.call();
      return FutureState.data(data: result);
    } on CustomException catch (ex) {
      return FutureState.failed(reason: errorMessage ?? ex.message);
    }
  }
}
