import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'lazy_async_value.codegen.freezed.dart';

@freezed
class LazyAsyncValue<T> with _$LazyAsyncValue<T> {
  const factory LazyAsyncValue({
    @Default(true) bool isIdle,
    required AsyncValue<T> value,
  }) = _LazyAsyncValue<T>;

  factory LazyAsyncValue.idle() => const LazyAsyncValue(value: AsyncValue.loading());
}
