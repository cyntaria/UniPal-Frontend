import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/student_connections_provider.dart';

// Models
import '../../models/student_connection_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';

// Widgets
import '../../../shared/widgets/error_response_handler.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/custom_circular_loader.dart';
import 'connection_action_buttons.dart';
import 'connection_list_item.dart';

class SentConnectionsList extends ConsumerWidget {
  const SentConnectionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget<List<StudentConnectionModel>>(
      value: ref.watch(sentConnectionsProvider),
      loading: () => const CustomCircularLoader(
        color: AppColors.primaryColor,
      ),
      error: (error, st) => ErrorResponseHandler(
        error: error,
        retryCallback: () => ref.refresh(sentConnectionsProvider),
        stackTrace: st,
      ),
      data: (requests) => AnimatedList(
        initialItemCount: requests.length,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (ctx, i, animation) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ConnectionListItem(
              studentConnection: requests[i],
              animation: animation,
              isReceived: false,
              actions: ConnectionActionButtons(
                isReceived: false,
                studentConnectionId: requests[i].studentConnectionId,
                onActionSuccess: () {
                  requests.removeAt(i);
                  AnimatedList.of(ctx).removeItem(
                    i,
                    (context, animation) => ConnectionListItem(
                      studentConnection: requests[i],
                      animation: animation,
                      isReceived: false,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
