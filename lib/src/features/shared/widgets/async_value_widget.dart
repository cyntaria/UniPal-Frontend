import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function() loading;
  final Widget Function()? emptyOrNull;
  final Widget Function()? onFirstLoad;
  final Widget Function(Object, StackTrace?) error;
  final Widget Function(T) data;

  const AsyncValueWidget({
    super.key,
    this.onFirstLoad,
    this.emptyOrNull,
    required this.value,
    required this.loading,
    required this.error,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (value.isRefreshing) return loading();
    return value.when(
      loading: onFirstLoad ?? loading,
      error: error,
      data: (d) {
        if (emptyOrNull != null) {
          if (d == null || (d is List && d.isEmpty)) {
            return emptyOrNull!.call();
          }
        }
        return data(d);
      },
    );
  }
}
