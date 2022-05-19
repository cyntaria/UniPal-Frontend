import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/requests_provider.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import 'hangout_list_item.dart';

class ReceivedHangoutsList extends ConsumerWidget {
  const ReceivedHangoutsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(
      requestsProvider.select(
        (value) => value.getAllReceivedHangoutRequests(),
      ),
    );
    return ListView.separated(
      itemCount: requests.length,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (_, __) => Insets.gapH15,
      padding: EdgeInsets.zero,
      itemBuilder: (_, i) => HangoutListItem(
        isReceived: true,
        authorImageUrl: requests[i]['sender']['profile_picture_url']! as String,
        authorErp: requests[i]['sender']['erp']! as String,
        purpose: requests[i]['purpose']! as String,
        authorName:
            '${requests[i]['sender']['first_name']} ${requests[i]['sender']['last_name']}',
        meetupAt: DateTime.parse(requests[i]['meetup_at']! as String),
        meetupSpotId: requests[i]['meetup_spot_id']! as int,
      ),
    );
  }
}
