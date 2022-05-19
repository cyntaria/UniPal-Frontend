import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/custom_exception.dart';

abstract class AsyncStateNotifier<T> extends StateNotifier<AsyncValue<T>> {
  AsyncStateNotifier(super.state);

  @protected
  Future<AsyncValue<T>> makeGuardedRequest(
    Future<T> Function() callback,
  ) async {
    try {
      final result = await callback.call();
      return AsyncValue.data(result);
    } on CustomException catch (ex, st) {
      return AsyncValue.error(ex.message, stackTrace: st);
    }
  }
}
