import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/requests_provider.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Widgets
import 'request_list_item.dart';

class ReceivedRequestsList extends ConsumerWidget {
  const ReceivedRequestsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(
      requestsProvider.select((value) => value.getAllReceivedRequests()),
    );
    return ListView.separated(
      itemCount: requests.length,
      separatorBuilder: (_, __) => Insets.gapH15,
      itemBuilder: (_, i) => RequestListItem(
        isReceived: true,
        authorImageUrl: requests[i]['sender']['profile_picture_url']! as String,
        authorErp: requests[i]['sender']['erp']! as String,
        authorName:
            '${requests[i]['sender']['first_name']} ${requests[i]['sender']['last_name']}',
        requestSentAt: DateTime.parse(requests[i]['sent_at']! as String),
      ),
    );
  }
}
