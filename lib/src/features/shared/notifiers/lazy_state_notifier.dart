import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// States
import '../states/lazy_async_value.codegen.dart';

abstract class LazyStateNotifier<T> extends StateNotifier<LazyAsyncValue<T>> {
  LazyStateNotifier(LazyAsyncValue<T> state) : super(state);

  late final AsyncLoading<T> _loading;

  @protected
  Future<void> makeRequest(Future<T> Function() callback) async {
    if (state.isIdle) state = state.copyWith(isIdle: false);

    if (state.value is AsyncLoading) {
      _loading = state.value as AsyncLoading<T>;
    } else {
      state = state.copyWith(value: _loading.copyWithPrevious(state.value));
    }

    final result = await AsyncValue.guard(callback);
    if (mounted) state = state.copyWith(value: result);
  }
}
