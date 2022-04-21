import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/requests_provider.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Widgets
import 'request_list_item.dart';

class SentRequestsList extends ConsumerWidget {
  const SentRequestsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(
      requestsProvider.select((value) => value.getAllSentRequests()),
    );
    return ListView.separated(
      itemCount: requests.length,
      separatorBuilder: (_, __) => Insets.gapH15,
      itemBuilder: (_, i) => RequestListItem(
        isReceived: false,
        authorImageUrl:
            requests[i]['receiver']['profile_picture_url']! as String,
        authorErp: requests[i]['receiver']['erp']! as String,
        authorName:
            '${requests[i]['receiver']['first_name']} ${requests[i]['receiver']['last_name']}',
        requestSentAt: DateTime.parse(requests[i]['sent_at']! as String),
      ),
    );
  }
}
