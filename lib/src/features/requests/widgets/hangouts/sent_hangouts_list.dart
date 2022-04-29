import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/requests_provider.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import 'hangout_list_item.dart';

class SentHangoutsList extends ConsumerWidget {
  const SentHangoutsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(
      requestsProvider.select(
        (value) => value.getAllSentHangoutRequests(),
      ),
    );
    return ListView.separated(
      itemCount: requests.length,
      separatorBuilder: (_, __) => Insets.gapH15,
      itemBuilder: (_, i) => HangoutListItem(
        isReceived: false,
        authorImageUrl:
            requests[i]['receiver']['profile_picture_url']! as String,
        authorErp: requests[i]['receiver']['erp']! as String,
        purpose: requests[i]['purpose']! as String,
        authorName:
            '${requests[i]['receiver']['first_name']} ${requests[i]['receiver']['last_name']}',
        meetupAt: DateTime.parse(requests[i]['meetup_at']! as String),
        meetupSpotId: requests[i]['meetup_spot_id']! as int,
      ),
    );
  }
}
