import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/hangout_request_provider.dart';

// Models
import '../../models/hangout_request_model.codegen.dart';

// Widgets
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/custom_circular_loader.dart';
import '../../../shared/widgets/custom_refresh_indicator.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../../../shared/widgets/error_response_handler.dart';
import 'hangout_action_buttons.dart';
import 'hangout_list_item.dart';

class SentHangoutsList extends ConsumerWidget {
  const SentHangoutsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomRefreshIndicator(
      onRefresh: () async => ref.refresh(sentHangoutsProvider),
      displacement: 21,
      child: AsyncValueWidget<List<HangoutRequestModel>>(
        value: ref.watch(sentHangoutsProvider),
        loading: () => const CustomCircularLoader(),
        error: (error, st) => ErrorResponseHandler(
          error: error,
          retryCallback: () => ref.refresh(sentHangoutsProvider),
          stackTrace: st,
        ),
        emptyOrNull: () => const SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: EmptyStateWidget(
            height: 395,
            width: double.infinity,
            margin: EdgeInsets.only(top: 20),
            title: 'No hangout requests sent!',
          ),
        ),
        data: (requests) => AnimatedList(
          initialItemCount: requests.length,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (ctx, i, animation) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: HangoutListItem(
              hangoutRequest: requests[i],
              animation: animation,
              isReceived: false,
              actions: HangoutActionButtons(
                isReceived: false,
                hangoutRequestId: requests[i].hangoutRequestId,
                onActionSuccess: () async {
                  final removed = requests.removeAt(i);
                  AnimatedList.of(ctx).removeItem(
                    i,
                    (context, animation) => HangoutListItem(
                      hangoutRequest: removed,
                      animation: animation,
                      isReceived: false,
                    ),
                  );
                  if (requests.isEmpty) ref.refresh(sentHangoutsProvider);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
