import 'package:flutter/material.dart';

class RequestListItem<T> extends StatelessWidget {
  final T request;

  const RequestListItem({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
