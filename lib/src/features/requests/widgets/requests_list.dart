import 'package:flutter/material.dart';

// Widgets
import 'request_list_item.dart';

class RequestsList<T> extends StatelessWidget {
  final List<T> requests;

  const RequestsList({
    Key? key,
    required this.requests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) => RequestListItem<T>(
          request: requests[i],
        ),
        childCount: requests.length,
      ),
    );
  }
}
